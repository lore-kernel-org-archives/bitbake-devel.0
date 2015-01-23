Return-Path: <rep.dot.nop@gmail.com>
Received: from mail-la0-f45.google.com (mail-la0-f45.google.com
	[209.85.215.45])
	by mail.openembedded.org (Postfix) with ESMTP id 5BB3465C7B
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 23 Jan 2015 13:30:53 +0000 (UTC)
Received: by mail-la0-f45.google.com with SMTP id gd6so7267392lab.4
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 23 Jan 2015 05:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc:content-type;
	bh=5D2G/DBqZsedsyipLOzxRreXPk2t1Opw0mSPNBgcNn4=;
	b=TpMeUbOS84IPmGRNpOru7nMVmhUXwErMLs+ZFR0++aO+ci0epAERRA8Y0BtXPrS5FZ
	/VAhsbBOs+CazlIqwhKQSWOoTaiN1yqnEEbmqFT/6/tOc9vLyRjWNYEvf+fbW49BVVNR
	wyXWe9FsBcAPVAQiYt9piwNa3T9+cZOitbXsB9T25OQSmSrrDQolu+BSW4bfx+Pg4df4
	+afuFqEg5LHfo+8CK+Gh+l3BrQ3ThikypXFx+z0NnDD22giQSq1vGps2x3DU+SiGZSkZ
	aMb7D+oxvjcN+KzUXxix064jvzbSD7afoSWfyTmg3t4WlgWRoUC+wYZhQQcLHn5K+9/f
	g3UQ==
MIME-Version: 1.0
X-Received: by 10.152.23.164 with SMTP id n4mr5271692laf.77.1422019852367;
	Fri, 23 Jan 2015 05:30:52 -0800 (PST)
Received: by 10.152.30.67 with HTTP; Fri, 23 Jan 2015 05:30:52 -0800 (PST)
In-Reply-To: <66552bf6a037bb239ee968038dc932595d294bdd.1421990462.git.Chong.Lu@windriver.com>
References: <cover.1421990461.git.Chong.Lu@windriver.com>
	<66552bf6a037bb239ee968038dc932595d294bdd.1421990462.git.Chong.Lu@windriver.com>
Date: Fri, 23 Jan 2015 14:30:52 +0100
Message-ID: <CAC1BbcS9Dw15zPQa3vQoc54+HN=G9Mqt3jyp6Uwye=LH_79=vQ@mail.gmail.com>
From: Bernhard Reutner-Fischer <rep.dot.nop@gmail.com>
To: Chong Lu <Chong.Lu@windriver.com>
Cc: paul.eggleton@linux.intel.com,
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH V3 2/2] bitbake-layers: add a ability to query layer dependencies from layer index
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 23 Jan 2015 13:30:59 -0000
Content-Type: text/plain; charset=UTF-8

On 23 January 2015 at 06:28, Chong Lu <Chong.Lu@windriver.com> wrote:
> Add a command to query layer dependencies from layer index. Fetch layer and its
> dependency layers and add them into conf/bblayers.conf.
>
> [YOCTO #5348]
>
> Signed-off-by: Chong Lu <Chong.Lu@windriver.com>
> ---
>  bitbake/bin/bitbake-layers | 190 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 190 insertions(+)
>
> diff --git a/bitbake/bin/bitbake-layers b/bitbake/bin/bitbake-layers
> index 9879498..222f685 100755
> --- a/bitbake/bin/bitbake-layers
> +++ b/bitbake/bin/bitbake-layers
> @@ -27,6 +27,8 @@ import sys
>  import fnmatch
>  from collections import defaultdict
>  import re
> +import httplib, urlparse, json
> +import subprocess
>
>  bindir = os.path.dirname(__file__)
>  topdir = os.path.dirname(bindir)
> @@ -157,6 +159,194 @@ usage: remove-layer <layerdir>
>                  sys.stderr.write("No layers matching %s found in BBLAYERS\n" % item)
>
>
> +    def get_json_data(self, apiurl):
> +        proxy_settings = os.environ.get("http_proxy", None)
> +        conn = None
> +        _parsedurl = urlparse.urlparse(apiurl)
> +        path = _parsedurl.path
> +        query = _parsedurl.query
> +        def parse_url(url):
> +            parsedurl = urlparse.urlparse(url)
> +            if parsedurl.netloc[0] == '[':
> +                host, port = parsedurl.netloc[1:].split(']', 1)
> +                if ':' in port:
> +                    port = port.rsplit(':', 1)[1]
> +                else:
> +                    port = None
> +            else:
> +                if parsedurl.netloc.count(':') == 1:
> +                    (host, port) = parsedurl.netloc.split(":")
> +                else:
> +                    host = parsedurl.netloc
> +                    port = None
> +            return (host, 80 if port is None else int(port))

well yea, except that does not help code-reuse to fix the
wrong splitport patterns used elsewhere in bitbake, unfortunately..


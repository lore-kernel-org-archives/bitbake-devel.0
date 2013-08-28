Return-Path: <jason.wessel@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id C63B66BC8A
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 28 Aug 2013 13:40:01 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id r7SDe1vX000253
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Wed, 28 Aug 2013 06:40:02 -0700 (PDT)
Received: from [172.25.32.37] (172.25.32.37) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.40) with Microsoft SMTP Server id 14.2.347.0;
	Wed, 28 Aug 2013 06:40:01 -0700
Message-ID: <521DFDAE.5040507@windriver.com>
Date: Wed, 28 Aug 2013 08:39:58 -0500
From: Jason Wessel <jason.wessel@windriver.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:17.0) Gecko/20130308 Thunderbird/17.0.4
MIME-Version: 1.0
To: "Peter A. Bigot" <pab@pabigot.com>
References: <1377695062-16111-1-git-send-email-pab@pabigot.com>
In-Reply-To: <1377695062-16111-1-git-send-email-pab@pabigot.com>
X-Enigmail-Version: 1.5.2
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] bitbake: server/xmlrpc/prserv: Increase timeout to default xmlrpc server
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
X-List-Received-Date: Wed, 28 Aug 2013 13:40:02 -0000
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

On 08/28/2013 08:04 AM, Peter A. Bigot wrote:
> On a heavily-loaded host with local PR server the default 5 second timeout
> produces too-frequent errors:
>
>   ERROR: Can NOT get PRAUTO, exception timed out
>   ERROR: Function failed: package_get_auto_pr
>
> Since this error aborts the build a generous timeout seems appropriate.
>
> Signed-off-by: Peter A. Bigot <pab@pabigot.com>
> ---
>  lib/bb/server/xmlrpc.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/bb/server/xmlrpc.py b/lib/bb/server/xmlrpc.py
> index 4dee5d9..bb87fd7 100644
> --- a/lib/bb/server/xmlrpc.py
> +++ b/lib/bb/server/xmlrpc.py
> @@ -78,7 +78,7 @@ class BBTransport(xmlrpclib.Transport):
>              h.putheader("Bitbake-token", self.connection_token)
>          xmlrpclib.Transport.send_content(self, h, body)
>  
> -def _create_server(host, port, timeout = 5):
> +def _create_server(host, port, timeout = 20):
>      t = BBTransport(timeout)
>      s = xmlrpclib.Server("http://%s:%d/" % (host, port), transport=t, allow_none=True)
>      return s, t


I would go so far as to make this 60 seconds and or have it a configurable parameter.

Previously the timeout was infinite.   I have observed process creation lagging by 30-45 seconds on a server with a load average of +300.   The new bitbake python code with the reduced timeout is not yet running on our edge case testing environment, but I do expect to hit the same issue.

Jason.


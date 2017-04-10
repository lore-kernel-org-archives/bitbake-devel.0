Return-Path: <patrick.ohly@intel.com>
Received: from mail-io0-f174.google.com (mail-io0-f174.google.com
	[209.85.223.174])
	by mail.openembedded.org (Postfix) with ESMTP id 0FAFB77BE0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Apr 2017 06:01:10 +0000 (UTC)
Received: by mail-io0-f174.google.com with SMTP id a103so18178679ioj.1
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 09 Apr 2017 23:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=message-id:subject:from:to:cc:date:in-reply-to:references
	:organization:mime-version:content-transfer-encoding;
	bh=calYmbXNHExHFbUhXxEf8l3Z+EZmLFh7FdHrk1DWj0s=;
	b=fvco0WBUggYB3LqD5TDIiF9lGtxgbMpSSnI3e6TVETdXQLf4awkyWReGsLqZ8VrNIl
	QTZrKpLjDUfKQFB8xWYLlj3WJH/RP9GjDl+TJxyNYrT57aKZYTD6pvqBg+YYTirTumNQ
	HrnEitywn7NRMvZ4nsHkLrM69GC8nxhX9JF6qwiVFWbF65czbHisYyZbZsFIaFftZ75S
	HBYpULfyY8iTE0+PPyzptYbWP7k03ID/QI/eH5gHpepeG+Cqsls7/VENg4mvzyeEUWyI
	tNunmOwysrmgdgl353Cv99ih3QS4hL2HEzCMEvwIKlMnYV9BMuZQ57c4Bv0WiSj91t+w
	nLpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
	:references:organization:mime-version:content-transfer-encoding;
	bh=calYmbXNHExHFbUhXxEf8l3Z+EZmLFh7FdHrk1DWj0s=;
	b=KjMWuHVIKcgrIed9npL2rrUL7gi0it0GpP6UgVLPdtiX6ZagsuHyL9A0a8zmNduED+
	HEwH5J/TcMdDfZDgYZmZx+7sJ/8J6diW5nw9MvyMomP5FVyMAROIdREoDy1wnxy7PIrY
	NHqsN8i0YC8Mfs4jkgLXFHBr/Ozcb5nX940Yll3vRZhRMXqr2hdUCVgsLFoDePYpYxf8
	hzLVOi96uPWFQGvGlFqH1NApkZCIwOcZkn+ZMO/Iz91PXGNqbI/f5fTwlPr1SrEnUCUV
	px7H0rVxX+16DaHlL2SSXq5tabqcV7X+aju65VMupwfN6WLHnuM38v7Wuf648NE+b3gT
	ZmUA==
X-Gm-Message-State: AFeK/H07gJtB/iBAWAbKqm3B1Ko2HU+VJYQjXf6YL/AxIPksLvmVc8O+Si47B6fN1bhFLZ+c
X-Received: by 10.107.47.102 with SMTP id j99mr50342032ioo.52.1491804071765;
	Sun, 09 Apr 2017 23:01:11 -0700 (PDT)
Received: from pohly-mobl1 (p57A56DBC.dip0.t-ipconnect.de. [87.165.109.188])
	by smtp.gmail.com with ESMTPSA id
	m83sm3657164ioi.32.2017.04.09.23.01.09
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 09 Apr 2017 23:01:10 -0700 (PDT)
Message-ID: <1491804067.10884.88.camel@intel.com>
From: Patrick Ohly <patrick.ohly@intel.com>
To: Juro Bystricky <juro.bystricky@intel.com>
Date: Mon, 10 Apr 2017 08:01:07 +0200
In-Reply-To: <1491672821-14233-1-git-send-email-juro.bystricky@intel.com>
References: <1491672821-14233-1-git-send-email-juro.bystricky@intel.com>
Organization: Intel GmbH, Dornacher Strasse 1, D-85622 Feldkirchen/Munich
X-Mailer: Evolution 3.12.9-1+b1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH v2] command.py: multiconfig support for findBestProvider
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
X-List-Received-Date: Mon, 10 Apr 2017 06:01:11 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Sat, 2017-04-08 at 10:33 -0700, Juro Bystricky wrote:
> In a multiconfig environment, a tinfoil call such as
> 
>     tinfoil.parse_recipe("multiconfig:arduino-101-sss:gcc")
> 
> can fail with an error such as:
> 
>   File "/data/master/poky/bitbake/lib/bb/tinfoil.py", line 373, in get_recipe_file
>     raise bb.providers.NoProvider('Unable to find any recipe file matching "%s"' % pn)
> bb.providers.NoProvider: Unable to find any recipe file matching "multiconfig:arduino-101-sss:gcc"
> 
> The culprit is findBestProvider, which does not handle multiconfig.
> This patch fixes the error and in the case mentioned above the tinfoil call returns:
> 
>   "multiconfig:arduino-101-sss:/data/master/poky/meta/recipes-devtools/gcc/gcc_6.3.bb"
> 
> [YOCTO#11210]
> 
> Signed-off-by: Juro Bystricky <juro.bystricky@intel.com>
> ---
>  bitbake/lib/bb/command.py | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/bitbake/lib/bb/command.py b/bitbake/lib/bb/command.py
> index 78a86ac..340842b 100644
> --- a/bitbake/lib/bb/command.py
> +++ b/bitbake/lib/bb/command.py
> @@ -141,6 +141,13 @@ class Command:
>          self.currentAsyncCommand = None
>          self.cooker.finishcommand()
>  
> +def split_mc_pn(pn):
> +    if pn.startswith("multiconfig:"):
> +        mc = pn.split(":")[1]
> +        pn = ":".join(pn.split(":")[2:])

I find this more readable:

if pn.startswith("multiconfig:"):
    _, mc, pn = pn.split(":", 2)

Not sure whether it is worth a v3, though.

-- 
Best Regards, Patrick Ohly

The content of this message is my personal opinion only and although
I am an employee of Intel, the statements I make here in no way
represent Intel's position on the issue, nor am I authorized to speak
on behalf of Intel on this matter.





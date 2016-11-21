Return-Path: <akuster808@gmail.com>
Received: from mail-pf0-f193.google.com (mail-pf0-f193.google.com
	[209.85.192.193])
	by mail.openembedded.org (Postfix) with ESMTP id 0ACE071A4F
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 21 Nov 2016 15:47:16 +0000 (UTC)
Received: by mail-pf0-f193.google.com with SMTP id i88so18494013pfk.2
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 21 Nov 2016 07:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=subject:to:references:from:message-id:date:user-agent:mime-version
	:in-reply-to:content-transfer-encoding;
	bh=+SbMxx5UvJ+blwJ6TfrtHuuj8eWgbhi5g/ygnT/CIy8=;
	b=qPRX0bK6i3wMVN35O/Eo/0ZIYM3BBQy60INVcTqsbrGHXBuGc0HE3d6bgp+kagXvPe
	N6vYI+er9RFoqlyrvh6YXDAYBxAg+35aJV0qFT/GYRigHMKdXDLb2RKR151fxPk9XfNh
	/vg4sBm7935iAieWj50EaoZhhkYiEcVgCO6F01u8FfOjlv7LO+OKYpylXgwLFu6XLMuo
	rO17RtbtNc10oBCti35dW7rPSl0JOeyNjH+vUBmWKEnclJA3ScTuegroMprk9YmK+qpg
	6LsWuSvqf6LxdiA5QJeLC+uDPOrmwz4WRaIuMOCfQzKFZ6zbzMctXSGS0tJ9zP+P7y/D
	j/VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:subject:to:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-transfer-encoding;
	bh=+SbMxx5UvJ+blwJ6TfrtHuuj8eWgbhi5g/ygnT/CIy8=;
	b=l/AO2VNfFDuBlzwDexELTW86c2nps78Uo/l4T1D2vHnEdM6LZXHtqaPRPpfxZUS1KU
	Z5z9XhnEJuKMLar1h34ilCVurWUOmYH+XaE3tsE4i4/UHXASaaXgbgwINUTt/o27ZxE5
	RUz4pgKMkEQ46nl2XsnrSV/3If9lzKfZC54Ddvxa8C2Hb+Nv2LVobGWgywLASnLQOlrD
	IUMpYL99oq6ETkE+YTutbKe264haFqtimUd3YTfs7DCI6jwjhEvj/oa9jYCfz83cHX+D
	MBnVJIo/ke/QQ1L35dYCy0WAQDISycPPR4rnTSyVoXRBP472zYdTT108XUzmFy7fPMdo
	JyMA==
X-Gm-Message-State: AKaTC014p6rbwPuEkRXzgjrCs5ZSIK3KtLuprPzw+jOqXSTJSj3R9rsF3fLlACY5XeOJFg==
X-Received: by 10.98.130.1 with SMTP id w1mr18787885pfd.35.1479743237847;
	Mon, 21 Nov 2016 07:47:17 -0800 (PST)
Received: from ?IPv6:2601:202:4001:9ea0:ea2a:eaff:fe0e:629e?
	([2601:202:4001:9ea0:ea2a:eaff:fe0e:629e])
	by smtp.gmail.com with ESMTPSA id 1sm10909296pgp.1.2016.11.21.07.47.16
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 21 Nov 2016 07:47:17 -0800 (PST)
To: Markus Lehtonen <markus.lehtonen@linux.intel.com>,
	bitbake-devel@lists.openembedded.org
References: <1479731503-12780-1-git-send-email-markus.lehtonen@linux.intel.com>
From: akuster808 <akuster808@gmail.com>
Message-ID: <6826906f-a5f8-baba-8c10-5f43424183ba@gmail.com>
Date: Mon, 21 Nov 2016 07:47:16 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
	Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <1479731503-12780-1-git-send-email-markus.lehtonen@linux.intel.com>
Subject: Re: [PATCH] fetch2: obey BB_ALLOWED_NETWORKS when checking network access
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
X-List-Received-Date: Mon, 21 Nov 2016 15:47:17 -0000
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit



On 11/21/2016 04:31 AM, Markus Lehtonen wrote:
> [YOCTO #10508]

I take it this applies to  1.32 ( Morty) as well.

-armin
>
> Signed-off-by: Markus Lehtonen <markus.lehtonen@linux.intel.com>
> ---
>   lib/bb/fetch2/__init__.py | 7 +++++--
>   lib/bb/fetch2/git.py      | 4 ++--
>   lib/bb/fetch2/hg.py       | 2 +-
>   lib/bb/fetch2/npm.py      | 2 +-
>   lib/bb/fetch2/perforce.py | 8 ++++----
>   lib/bb/fetch2/svn.py      | 2 +-
>   lib/bb/fetch2/wget.py     | 2 +-
>   7 files changed, 15 insertions(+), 12 deletions(-)
>
> diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
> index cd7362c..4bb7526 100644
> --- a/lib/bb/fetch2/__init__.py
> +++ b/lib/bb/fetch2/__init__.py
> @@ -856,12 +856,15 @@ def runfetchcmd(cmd, d, quiet=False, cleanup=None, log=None, workdir=None):
>   
>       return output
>   
> -def check_network_access(d, info = "", url = None):
> +def check_network_access(d, info, url):
>       """
> -    log remote network access, and error if BB_NO_NETWORK is set
> +    log remote network access, and error if BB_NO_NETWORK is set or the given
> +    URI is untrusted
>       """
>       if d.getVar("BB_NO_NETWORK", True) == "1":
>           raise NetworkAccess(url, info)
> +    elif not trusted_network(d, url):
> +        raise UntrustedUrl(url, info)
>       else:
>           logger.debug(1, "Fetcher accessed the network with the command %s" % info)
>   
> diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
> index 1bec60a..11d0b9c 100644
> --- a/lib/bb/fetch2/git.py
> +++ b/lib/bb/fetch2/git.py
> @@ -252,7 +252,7 @@ class Git(FetchMethod):
>                   repourl = repourl[7:]
>               clone_cmd = "LANG=C %s clone --bare --mirror %s %s --progress" % (ud.basecmd, repourl, ud.clonedir)
>               if ud.proto.lower() != 'file':
> -                bb.fetch2.check_network_access(d, clone_cmd)
> +                bb.fetch2.check_network_access(d, clone_cmd, ud.url)
>               progresshandler = GitProgressHandler(d)
>               runfetchcmd(clone_cmd, d, log=progresshandler)
>   
> @@ -384,7 +384,7 @@ class Git(FetchMethod):
>           cmd = "%s ls-remote %s %s" % \
>                 (ud.basecmd, repourl, search)
>           if ud.proto.lower() != 'file':
> -            bb.fetch2.check_network_access(d, cmd)
> +            bb.fetch2.check_network_access(d, cmd, repourl)
>           output = runfetchcmd(cmd, d, True)
>           if not output:
>               raise bb.fetch2.FetchError("The command %s gave empty output unexpectedly" % cmd, ud.url)
> diff --git a/lib/bb/fetch2/hg.py b/lib/bb/fetch2/hg.py
> index 20df801..dc87998 100644
> --- a/lib/bb/fetch2/hg.py
> +++ b/lib/bb/fetch2/hg.py
> @@ -221,7 +221,7 @@ class Hg(FetchMethod):
>           """
>           Compute tip revision for the url
>           """
> -        bb.fetch2.check_network_access(d, self._buildhgcommand(ud, d, "info"))
> +        bb.fetch2.check_network_access(d, self._buildhgcommand(ud, d, "info"), ud.url)
>           output = runfetchcmd(self._buildhgcommand(ud, d, "info"), d)
>           return output.strip()
>   
> diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py
> index 699ae72..29faea1 100644
> --- a/lib/bb/fetch2/npm.py
> +++ b/lib/bb/fetch2/npm.py
> @@ -101,7 +101,7 @@ class Npm(FetchMethod):
>   
>       def _runwget(self, ud, d, command, quiet):
>           logger.debug(2, "Fetching %s using command '%s'" % (ud.url, command))
> -        bb.fetch2.check_network_access(d, command)
> +        bb.fetch2.check_network_access(d, command, ud.url)
>           dldir = d.getVar("DL_DIR", True)
>           runfetchcmd(command, d, quiet, workdir=dldir)
>   
> diff --git a/lib/bb/fetch2/perforce.py b/lib/bb/fetch2/perforce.py
> index 50cb479..e332e7c 100644
> --- a/lib/bb/fetch2/perforce.py
> +++ b/lib/bb/fetch2/perforce.py
> @@ -71,7 +71,7 @@ class Perforce(FetchMethod):
>               logger.debug(1, 'Trying to use P4CONFIG to automatically set P4PORT...')
>               ud.usingp4config = True
>               p4cmd = '%s info | grep "Server address"' % ud.basecmd
> -            bb.fetch2.check_network_access(d, p4cmd)
> +            bb.fetch2.check_network_access(d, p4cmd, ud.url)
>               ud.host = runfetchcmd(p4cmd, d, True)
>               ud.host = ud.host.split(': ')[1].strip()
>               logger.debug(1, 'Determined P4PORT to be: %s' % ud.host)
> @@ -140,7 +140,7 @@ class Perforce(FetchMethod):
>           'p4 files' command, including trailing '#rev' file revision indicator
>           """
>           p4cmd = self._buildp4command(ud, d, 'files')
> -        bb.fetch2.check_network_access(d, p4cmd)
> +        bb.fetch2.check_network_access(d, p4cmd, ud.url)
>           p4fileslist = runfetchcmd(p4cmd, d, True)
>           p4fileslist = [f.rstrip() for f in p4fileslist.splitlines()]
>   
> @@ -171,7 +171,7 @@ class Perforce(FetchMethod):
>   
>           for afile in filelist:
>               p4fetchcmd = self._buildp4command(ud, d, 'print', afile)
> -            bb.fetch2.check_network_access(d, p4fetchcmd)
> +            bb.fetch2.check_network_access(d, p4fetchcmd, ud.url)
>               runfetchcmd(p4fetchcmd, d, workdir=ud.pkgdir)
>   
>           runfetchcmd('tar -czf %s p4' % (ud.localpath), d, cleanup=[ud.localpath], workdir=ud.pkgdir)
> @@ -191,7 +191,7 @@ class Perforce(FetchMethod):
>       def _latest_revision(self, ud, d, name):
>           """ Return the latest upstream scm revision number """
>           p4cmd = self._buildp4command(ud, d, "changes")
> -        bb.fetch2.check_network_access(d, p4cmd)
> +        bb.fetch2.check_network_access(d, p4cmd, ud.url)
>           tip = runfetchcmd(p4cmd, d, True)
>   
>           if not tip:
> diff --git a/lib/bb/fetch2/svn.py b/lib/bb/fetch2/svn.py
> index 6ca79d3..71dee9f 100644
> --- a/lib/bb/fetch2/svn.py
> +++ b/lib/bb/fetch2/svn.py
> @@ -173,7 +173,7 @@ class Svn(FetchMethod):
>           """
>           Return the latest upstream revision number
>           """
> -        bb.fetch2.check_network_access(d, self._buildsvncommand(ud, d, "log1"))
> +        bb.fetch2.check_network_access(d, self._buildsvncommand(ud, d, "log1"), ud.url)
>   
>           output = runfetchcmd("LANG=C LC_ALL=C " + self._buildsvncommand(ud, d, "log1"), d, True)
>   
> diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
> index ecb946a..1d81c08 100644
> --- a/lib/bb/fetch2/wget.py
> +++ b/lib/bb/fetch2/wget.py
> @@ -95,7 +95,7 @@ class Wget(FetchMethod):
>           progresshandler = WgetProgressHandler(d)
>   
>           logger.debug(2, "Fetching %s using command '%s'" % (ud.url, command))
> -        bb.fetch2.check_network_access(d, command)
> +        bb.fetch2.check_network_access(d, command, ud.url)
>           runfetchcmd(command + ' --progress=dot -v', d, quiet, log=progresshandler)
>   
>       def download(self, ud, d):



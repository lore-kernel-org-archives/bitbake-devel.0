Return-Path: <akuster@mvista.com>
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com
	[209.85.215.194])
	by mail.openembedded.org (Postfix) with ESMTP id B887D7FC7B
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 19 Sep 2019 18:02:17 +0000 (UTC)
Received: by mail-pg1-f194.google.com with SMTP id z12so2310322pgp.9
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 19 Sep 2019 11:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mvista-com.20150623.gappssmtp.com; s=20150623;
	h=subject:to:references:from:openpgp:autocrypt:message-id:date
	:user-agent:mime-version:in-reply-to:content-transfer-encoding
	:content-language;
	bh=gYVL9B42YXpe6LI5owVPzBOJj9vYFE8S49oND6va3Bo=;
	b=u+1T/A8+51x/sTF81x5DjsOCeX1TDXGxm7vaBZRgGIIYV7ukUjSKV6FJWwcU5j7L3t
	qYIIs+n39Fn4ieu6Tworul7CsRCJQFJSX6RI8oS7ThHk58FXmwPnKdxP8sQj29lxYDiw
	fJ0yCd0s9TYsYlp/gVMr2Lq7tCE977UTLKowm/cThlaWQEcQJLWSgIQaoG93gx1K1uqm
	8ZPMwD+2OVg6DaMQrjS/4JzzUcRzawxb44xtiSWzsJDTIMFpbxxj2Bk/skMex2Wq0UMQ
	dDuehn6NcXWwO9Fel7fiH60aaro1igGxDr/XVSZJqDpKMtMdwkK0r6G1lemOpnogH+p0
	lBfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:autocrypt
	:message-id:date:user-agent:mime-version:in-reply-to
	:content-transfer-encoding:content-language;
	bh=gYVL9B42YXpe6LI5owVPzBOJj9vYFE8S49oND6va3Bo=;
	b=rxT0eExksCFT6kzqr59RudVX8d5UMMIlNIIHNGJcDO8jE1UAtlxWMQz85CfM8zn2j+
	ePZDIFS7Fo57RJ1d76BBs7Ln3Bzniv29X+NYfPkNliBq3DWHZI/FP+HoYSemvCKH6eJO
	M3ZUZVQX4FN3gNKMLn3xGKem51jzFrX27wsOvLe8nMuWBqjN9BoomdnV6UWJtLikN5k/
	LtXnHMEh99Yv3Nxd7GqC/783Da6am/Knzwkt3vlOJmy7y9LQpS2nOvaphHo4MxCRaT8j
	Lf2u/zvmXDwdsqX9odgUApkfTDKn6HET279dtaQ7bxiVVy/ySZFfj4dChx5j6dRGLfkM
	e0Rg==
X-Gm-Message-State: APjAAAW4iIvKT3mDZiBV9VTA4/oCjuFvROFS7Y5XDKkiBeHeTkzzWXsN
	fE36fm/EiSc7nbkDBWb3rNXjtUyNV1M=
X-Google-Smtp-Source: APXvYqzoWvW9qT0GKbLw7P5cuRAbfSNgEtLTFFfA3svj05MSE4r20Yz2drFgQhgKwo+Cp+WEqBOyMA==
X-Received: by 2002:a62:18d6:: with SMTP id 205mr12203977pfy.90.1568916138016; 
	Thu, 19 Sep 2019 11:02:18 -0700 (PDT)
Received: from ?IPv6:2601:202:4180:c33:f8c7:8a0b:73aa:3f22?
	([2601:202:4180:c33:f8c7:8a0b:73aa:3f22])
	by smtp.gmail.com with ESMTPSA id
	u5sm14266950pfl.25.2019.09.19.11.02.16
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 19 Sep 2019 11:02:17 -0700 (PDT)
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	bitbake-devel@lists.openembedded.org
References: <20190919155122.28732-1-richard.purdie@linuxfoundation.org>
From: akuster <akuster@mvista.com>
Openpgp: preference=signencrypt
Autocrypt: addr=akuster@mvista.com; prefer-encrypt=mutual; keydata=
	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
	8CS2NxU=
Message-ID: <b3abe85f-fcb5-69ca-4f05-11a1437b19ae@mvista.com>
Date: Thu, 19 Sep 2019 11:02:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190919155122.28732-1-richard.purdie@linuxfoundation.org>
Subject: Re: [PATCH] utils: Add ionice option to prunedir
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
X-List-Received-Date: Thu, 19 Sep 2019 18:02:17 -0000
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US



On 9/19/19 8:51 AM, Richard Purdie wrote:
> Autobuilder type infrastructure can benefit from deletion of certain files as
> background IO due to the way Linux filesystem priority works.
>
> We have problems where build directories as part of oe-selftest being
> delete starves the running tasks of IO to the point builds take much
> longer to compelte.
>
> Having this option of running the deletion at "idle" helps a lot with
> that.
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  lib/bb/utils.py | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/lib/bb/utils.py b/lib/bb/utils.py
> index 3e90b6a306..d035949b3d 100644
> --- a/lib/bb/utils.py
> +++ b/lib/bb/utils.py
> @@ -677,7 +677,7 @@ def _check_unsafe_delete_path(path):
>          return True
>      return False
>  
> -def remove(path, recurse=False):
> +def remove(path, recurse=False, ionice=False):
>      """Equivalent to rm -f or rm -rf"""
>      if not path:
>          return
> @@ -686,7 +686,10 @@ def remove(path, recurse=False):
>              if _check_unsafe_delete_path(path):
>                  raise Exception('bb.utils.remove: called with dangerous path "%s" and recurse=True, refusing to delete!' % path)
>          # shutil.rmtree(name) would be ideal but its too slow
> -        subprocess.check_call(['rm', '-rf'] + glob.glob(path))
> +        cmd = []
> +        if ionice:
> +            cmd = ['ionice', '-c', '3']
Would allowing folks to configure the ionice value apply here?

- armin
> +        subprocess.check_call(cmd + ['rm', '-rf'] + glob.glob(path))
>          return
>      for name in glob.glob(path):
>          try:
> @@ -695,12 +698,12 @@ def remove(path, recurse=False):
>              if exc.errno != errno.ENOENT:
>                  raise
>  
> -def prunedir(topdir):
> +def prunedir(topdir, ionice=False):
>      # Delete everything reachable from the directory named in 'topdir'.
>      # CAUTION:  This is dangerous!
>      if _check_unsafe_delete_path(topdir):
>          raise Exception('bb.utils.prunedir: called with dangerous path "%s", refusing to delete!' % topdir)
> -    remove(topdir, recurse=True)
> +    remove(topdir, recurse=True, ionice=ionice)
>  
>  #
>  # Could also use return re.compile("(%s)" % "|".join(map(re.escape, suffixes))).sub(lambda mo: "", var)



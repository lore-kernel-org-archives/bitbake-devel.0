Return-Path: <nicolas.dechesne@linaro.org>
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com
	[209.85.167.51])
	by mail.openembedded.org (Postfix) with ESMTP id 058EC7C86A
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  6 Nov 2019 04:50:30 +0000 (UTC)
Received: by mail-lf1-f51.google.com with SMTP id y6so16949471lfj.2
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 05 Nov 2019 20:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=bNFmatGc3po1Zst+rzbHDv1zBWTyIKlp5NwLlCFP4tA=;
	b=tfYKEE1wSnRa/k+RjuIH+t8Eokx6ZK6RxX9GkmKBzjN1uE1p2jKo3tFIDL2LgdCpen
	D0CpT95NUu6OFzJaESRVvcaySdLUoJwJLIs5AB+WKJaRrS4x+pHUjK9vFnj2cODscgSu
	8D/2zP7ACspQNqmAuZReXeHiTOwgAzUMDACFZZeaFa8vIEOlvgZTG/7nHXVgDw39oiTr
	IVw15sfVSSA8NV8GiuDtSlZrUYOD61cHrR9TYHz0KvRABNkAI7UiaJrO3I9bb3YDOTWx
	bfqblGczq2qAkXwC3KDYpX2CrmKbtFhprwBH3yHrf69wNv8Va2PJS+Ai28onDLUXEXHd
	o15g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=bNFmatGc3po1Zst+rzbHDv1zBWTyIKlp5NwLlCFP4tA=;
	b=cLrRqvKSTlKm5YXKpKmRKtnXXNtsfbDZoLGvf2UBhVa318JQOm19WSXcl18NlJjtlx
	hqVLP5Jzp9u7j9NN0u2OQ1X9VCcTWkra3uHQO1QlRLu8B2pJ832hjTtLGsOBR0U0A6sA
	0JxNwrlGz5+Io8mVNPYok5TPls6k58eeCJAkRLNs2ZQ7QvIT+r1F3FUZCkTL3DvTAXFN
	VBscgsZSK6zpRzzOcHgkLEBRXYvpZ2eF/uRhYTJ7HVGJOIVZyPpNn5aWnrG6e38j74qz
	g8eLLRQtOk4tUwA+raSyfMb++HM3oj72jXd7eKvTWzM58//KmM7c3/D2zRzSgjvByKmn
	b2jg==
X-Gm-Message-State: APjAAAWxfiRkl0i+embs0Od4YJPt0lJwY4jLb6KAilAcInktZ/pa2Amv
	i6cj3d96096OynH38Hy95MWgCtvkbjokd44OKWLPwg==
X-Google-Smtp-Source: APXvYqxEHSNeiH/inMbYsT14DmfHctGeiZNSjmLNE6ZAIz6OmkHQVG9Y0VbvOj+Dn6H7EERITRM3cMj63+AlZAjq24w=
X-Received: by 2002:a19:614b:: with SMTP id m11mr4101316lfk.157.1573015831294; 
	Tue, 05 Nov 2019 20:50:31 -0800 (PST)
MIME-Version: 1.0
References: <20191008184512.20130-1-anibal.limon@linaro.org>
In-Reply-To: <20191008184512.20130-1-anibal.limon@linaro.org>
From: Nicolas Dechesne <nicolas.dechesne@linaro.org>
Date: Wed, 6 Nov 2019 05:50:22 +0100
Message-ID: <CAP71WjybOqGNu8Js9pnPEHsuYHRe5LVPgCdei7FsvqQG_L5U1A@mail.gmail.com>
To: =?UTF-8?B?QW7DrWJhbCBMaW3Ds24=?= <anibal.limon@linaro.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [RFC][WIP][PATCHv1] lib/bb/checksum.py: Speed-up checksum gen when directory is git
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
X-List-Received-Date: Wed, 06 Nov 2019 04:50:31 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

hi,

On Tue, Oct 8, 2019 at 8:42 PM An=C3=ADbal Lim=C3=B3n <anibal.limon@linaro.=
org> wrote:
>
> In some cases people/organizations are using a SRC_URI with
> file:///PATH_TO_DIR that contains a git repository for different
> reasons, it is useful when want to do an internal build without
> clone sources from outside.
>
> This could consume a lot of CPU time because the current taskhash
> generation mechanism didn't identify that the folder is a VCS
> (git, svn, cvs) and makes the cksum for every file including the
> .git repository in this case.
>
> There are different ways to improve the situation,
>
> * Add protocol=3Dgitscm in file:// SRC_URI but the taskhash is
>   calculated before the fetcher identifies the protocol, will require
>   some changes in bitbake codebase.
> * This patch: When directory is a git repository (contains .git)
>   use HEAD rev + git diff to calculate checksum instead of do it
>   in every file, that is hackish because make some assumptions about
>   .git directory contents.
> * Variant of this patch: Make a list of VCS directories (.git, .svn,
>   .cvs) and take out for cksum calculations, same as before making
>   assumptions about the . folders content.

I've discussed with Khem and Richard today (@ELCE) about this patch.
We kind of agreed that the current approach is not really good since
the local fetcher isn't supposed to 'deal' with scm commands. however
we agreed that the last variant proposed above might be a much better
approach. The idea would be to exclude VCS directories from the
checksum computation. It could potentially be extended in a slightly
more generic way, like using a variable to specify a list of
directories to exclude, which could be unset by default, and set in oe
core as
BB_LOCAL_DIRS_EXCLUDE =3D ".git .cvs .svn"

Anibal: do you think you can give it a try?


>
> Signed-off-by: An=C3=ADbal Lim=C3=B3n <anibal.limon@linaro.org>
> ---
>  lib/bb/checksum.py | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/lib/bb/checksum.py b/lib/bb/checksum.py
> index 5bc8a8fc..ee125cb5 100644
> --- a/lib/bb/checksum.py
> +++ b/lib/bb/checksum.py
> @@ -86,6 +86,19 @@ class FileChecksumCache(MultiProcessCache):
>              return checksum
>
>          def checksum_dir(pth):
> +            git_dir =3D os.path.join(pth, '.git')
> +            if os.path.exists(git_dir):
> +                import subprocess, hashlib
> +                m =3D hashlib.md5()
> +                head =3D subprocess.check_output("cd %s && git rev-parse=
 HEAD" % pth, shell=3DTrue)
> +                diff =3D subprocess.check_output("cd %s && git diff" % p=
th, shell=3DTrue)
> +                m.update(head)
> +                if diff:
> +                    m.update(diff)
> +
> +                return [(pth, m.hexdigest())]
> +
> +
>              # Handle directories recursively
>              if pth =3D=3D "/":
>                  bb.fatal("Refusing to checksum /")
> --
> 2.23.0
>


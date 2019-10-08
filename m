Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
	[209.85.221.68])
	by mail.openembedded.org (Postfix) with ESMTP id DC1807F44B
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  8 Oct 2019 23:15:52 +0000 (UTC)
Received: by mail-wr1-f68.google.com with SMTP id n14so171834wrw.9
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 08 Oct 2019 16:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:cc:date:in-reply-to:references
	:user-agent:mime-version:content-transfer-encoding;
	bh=We6DlVYVauDClLR2RFHZOkRlXwpx9X8KOfG6Q7UduoU=;
	b=MKBrJOCRMDlVnWC1u1hbY9N9HATT6t1fG0XDHXsTHMgfQcTNCKchz4GZoPKjoIkCst
	cu2FRA8uYPk8ftvyxonWXdW0xusK2+oLrfXQArYCGlVpXCNZ2AjIhvIwpwj5RSZShw/h
	eF+Jp/V3cDXsEw6kS1e80gbp68z/JDpFjf5A8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
	:references:user-agent:mime-version:content-transfer-encoding;
	bh=We6DlVYVauDClLR2RFHZOkRlXwpx9X8KOfG6Q7UduoU=;
	b=Ag5mO85954kB7pXsRO465MbPHgCG4SMxOw1S07N05w95yC0sbhjt6CgkcfRbByJtUb
	tGC6UTWZIHzLcCSWqBE+l6pU0vbM7aA0HoUFhKRm9idGXSyH2x7Pd3y7Ja0rFPvB5lYu
	5uV3/ieCCWMvHC8EFKI3Kr61a6G75GKuctU4OBFe3mCHJbRSSY1xfCh2WzwYsaqtclDe
	q/GECeI/mIATjpnP2OGGuCyucF0U2IBAERcSG/u8wrEPwdbQ90JZ1sIPo79C1J9sBNvO
	vsKt9tgThf/09iAyOaZ6X67E6LKUSjy/erywrMYnjXdKt2bbndPqRjL3zlphEFJxo1cu
	aIPQ==
X-Gm-Message-State: APjAAAUIvTLSd87ly3XFa/JwygdGggjiKPyVe3eqCd1GtnYiPYNO3366
	WaT3rDgxBB64+W9vKhfbwfgu/w==
X-Google-Smtp-Source: APXvYqz531TIoFFHTXk/Buq5Rz7Gdk8l67a5t415B99qEIzOJMKZqMvz0AWEoO3+FHo8ZG/60ISS+A==
X-Received: by 2002:a5d:4287:: with SMTP id k7mr241463wrq.283.1570576553024;
	Tue, 08 Oct 2019 16:15:53 -0700 (PDT)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id x129sm301648wmg.8.2019.10.08.16.15.51
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Tue, 08 Oct 2019 16:15:52 -0700 (PDT)
Message-ID: <47c79ccca81ec9c237357f4a91973d2b6cee77e1.camel@linuxfoundation.org>
From: richard.purdie@linuxfoundation.org
To: =?ISO-8859-1?Q?An=EDbal_Lim=F3n?= <anibal.limon@linaro.org>, 
	bitbake-devel@lists.openembedded.org
Date: Wed, 09 Oct 2019 00:15:50 +0100
In-Reply-To: <20191008184512.20130-1-anibal.limon@linaro.org>
References: <20191008184512.20130-1-anibal.limon@linaro.org>
User-Agent: Evolution 3.34.0-1 
MIME-Version: 1.0
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
X-List-Received-Date: Tue, 08 Oct 2019 23:15:53 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Tue, 2019-10-08 at 13:45 -0500, Aníbal Limón wrote:
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
> * Add protocol=gitscm in file:// SRC_URI but the taskhash is
>   calculated before the fetcher identifies the protocol, will require
>   some changes in bitbake codebase.
> * This patch: When directory is a git repository (contains .git)
>   use HEAD rev + git diff to calculate checksum instead of do it
>   in every file, that is hackish because make some assumptions about
>   .git directory contents.
> * Variant of this patch: Make a list of VCS directories (.git, .svn,
>   .cvs) and take out for cksum calculations, same as before making
>   assumptions about the . folders content.

This is an interesting one.

File checksums are added to the hashes "late" so that we don't have to
reparse entire recipes when files change. We do need a mechanism to
know when we need to reparse the checksum. I think this means you can
skip the checksum calculation for each file but you do still end up
having to stat all files in the tree separately for bitbake's tracking
and for git. We also have to notice when new files are added.

As such I'm not convinced this patch will work correctly (e.g. would it
notice if I copy in a new file to the directory untracked by git). 

A first step may be to add some further tests to bitbake-selftest to
better cover this area...

Cheers,

Richard







Return-Path: <nicolas.dechesne@linaro.org>
Received: from mail-lf1-f68.google.com (mail-lf1-f68.google.com
	[209.85.167.68])
	by mail.openembedded.org (Postfix) with ESMTP id 06D6F7D97D
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  9 Oct 2019 09:02:22 +0000 (UTC)
Received: by mail-lf1-f68.google.com with SMTP id r22so1061163lfm.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 09 Oct 2019 02:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=eFajWrLkbhnaXi3Np0b6lOWEZrDWbd3zKl4jYHXJ2jY=;
	b=iQilfvH95YI7TRitMxiCXiaXD6xBQAq2rhQ85fs/0l+INq15K/FltljM4TFsE8vpeo
	8pK1hGfNfrug0lEVP0m5/IuggSq6K461QMxyAmunAhorA/qxqQDIm4lzkRwZtTR6ARXV
	06B0Kw/561XUzMRBhSt7Ca14ut8vuG2P+GplkX7vx9TcZdZQj3rZTy7HyG473dSdljNs
	rFcBtvNOaMc2dYDPxvZ6b+yewOedULBpWo0nP3jzY9a/vP9ua23oSS2iYAyDvNU/75Ja
	mCaAYSkvwGwCEOT9c1zRCK2uR2HL+aK3Ht+GBGbAf38hfqNdrbM5HvWuHdBOCPzw4DCS
	13dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=eFajWrLkbhnaXi3Np0b6lOWEZrDWbd3zKl4jYHXJ2jY=;
	b=ABa5U6MgcupKtKLjEJX1BoSvPWOo+URXULQwG1+/ruNWZH8y3MUc5JOIkD5u9MSlzH
	NHYNLmdAn13h2nSq3dEq7kPvxEAntnLLDK+lP26RIJa4kIFsDFfx9TL/vOf7z9gZAob/
	NfAhr3RZ44bSsA9ZtWbgAdeCPQaqU6IeWP7nijIo0VjGkqqEi06qbxJbyM3j3CuQzbvf
	64/p4Ws0VZ+W0z3ydu9EYsyWxFPgYlFBeC8ypl2i16E5NKwwCJ/pIPPrPw/R4fakcg1P
	v6qtlXNq756ib8NSY+GoBHJ3MNYvY0nGnuy+7neNSfKkpnFo3521ItMHTXZCg9x7T9WL
	L9yA==
X-Gm-Message-State: APjAAAVpieLNxqxUgdNX1955gO35d+4a/DYyGlXTRjSqkotwp7LBz3Eq
	eE4al/wNmEgpFlLepob2d59lwSVMNpcFna+gKcRsyQ==
X-Google-Smtp-Source: APXvYqw8qUnOOs72TYUNvcrK8WmE943hj+8nZJpX3W4T2ynaIR7lrD7A1aDBKkRiADdtDvkDJin90CJOc7YoP6Wm2Uw=
X-Received: by 2002:ac2:5924:: with SMTP id v4mr1377875lfi.29.1570611743360;
	Wed, 09 Oct 2019 02:02:23 -0700 (PDT)
MIME-Version: 1.0
References: <20191008184512.20130-1-anibal.limon@linaro.org>
	<47c79ccca81ec9c237357f4a91973d2b6cee77e1.camel@linuxfoundation.org>
In-Reply-To: <47c79ccca81ec9c237357f4a91973d2b6cee77e1.camel@linuxfoundation.org>
From: Nicolas Dechesne <nicolas.dechesne@linaro.org>
Date: Wed, 9 Oct 2019 11:02:11 +0200
Message-ID: <CAP71WjyAPhw6f+9ZW0NMdzhV-cwWcNc3SLCO74Sv+noXnyX7tA@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
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
X-List-Received-Date: Wed, 09 Oct 2019 09:02:23 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2019 at 1:15 AM <richard.purdie@linuxfoundation.org> wrote:
>
> On Tue, 2019-10-08 at 13:45 -0500, An=C3=ADbal Lim=C3=B3n wrote:
> > In some cases people/organizations are using a SRC_URI with
> > file:///PATH_TO_DIR that contains a git repository for different
> > reasons, it is useful when want to do an internal build without
> > clone sources from outside.
> >
> > This could consume a lot of CPU time because the current taskhash
> > generation mechanism didn't identify that the folder is a VCS
> > (git, svn, cvs) and makes the cksum for every file including the
> > .git repository in this case.
> >
> > There are different ways to improve the situation,
> >
> > * Add protocol=3Dgitscm in file:// SRC_URI but the taskhash is
> >   calculated before the fetcher identifies the protocol, will require
> >   some changes in bitbake codebase.
> > * This patch: When directory is a git repository (contains .git)
> >   use HEAD rev + git diff to calculate checksum instead of do it
> >   in every file, that is hackish because make some assumptions about
> >   .git directory contents.
> > * Variant of this patch: Make a list of VCS directories (.git, .svn,
> >   .cvs) and take out for cksum calculations, same as before making
> >   assumptions about the . folders content.
>
> This is an interesting one.

Are you referring to the last bullet here? I suspect it's the second one.

Also to give a bit more background to everyone, as it might not be
obvious. I've seen the same pattern used several times , especially in
large/corporate deployment of OE/YP. the whole build workspace is
built as:

|- sources
|---- kernel
|---- component_A
|---- component_B
|- layers
|---- poky
|---- meta-mycompany
|-------- recipes for kernel, component_A, ...

The whole workspace is managed with a repo manifest, and the recipes
are written to use source code from the 'sources' local folder.

I am not trying to argue whether this is a good practice or not ;-)
but from the perspectives of the folks I've talked to , there are a
couple of critical advantages of doing something like that:
* it looks like Android development workflow ;-)
* it relates to the company license/legal process and review. e.g. all
the software that gets out of the company is managed by a single repo
manifest xml file
* it solves "nicely" the problem of being able to iteratively develop
using bitbake natively. e.g. "bibtake myimage" always work, and uses
local changes from 'sources'

So overall, i am being convinced that this is a valid use case for OE
end users. I don't think we can use the git:// fetcher as we need the
snapshot of the current 'sources' (with local changes), and using the
file:// fetcher has important performance impacts:
* checksum for 'each' file (which can be large, especially for kernel)
* un-expected rebuild when running repo sync, if any new git objects
are put in .git (even when no changes are made to the local worktree
of the git project).

>
> File checksums are added to the hashes "late" so that we don't have to
> reparse entire recipes when files change. We do need a mechanism to
> know when we need to reparse the checksum. I think this means you can
> skip the checksum calculation for each file but you do still end up
> having to stat all files in the tree separately for bitbake's tracking
> and for git. We also have to notice when new files are added.
>
> As such I'm not convinced this patch will work correctly (e.g. would it
> notice if I copy in a new file to the directory untracked by git).

At least I confirm that with the file:// fetcher everything works
fine, when modifying files. I don't think I have tried adding new
files. But I will try that.

Are you trying to say that to fix this properly we might need another
Fetcher , something in between file:// and git://, e.g. localgit://?
Would that make this problem easier to solve?

>
> A first step may be to add some further tests to bitbake-selftest to
> better cover this area...
>
> Cheers,
>
> Richard
>
>
>
>
>


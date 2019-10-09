Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
	[209.85.221.65])
	by mail.openembedded.org (Postfix) with ESMTP id 994C97D5C4
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  9 Oct 2019 11:53:34 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id j11so2594847wrp.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 09 Oct 2019 04:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:cc:date:in-reply-to:references
	:user-agent:mime-version:content-transfer-encoding;
	bh=OAUyf37iUZIf611/kj0iVS0WdmqqhPqTf76z5dMsVCc=;
	b=D4QTm221JC/98+str+dajMty6ZgE/i1Et/INwFlVXDkWPj/ed/QaEzufPAQd4ctZ6V
	W/BYTh6ARVU8Pqyjgoo5JmuKhln4DgZHkSZS9B8N7Mat7fdzEnh5OHzIJ3/i+S9rjat+
	iYJOLLpCIlmMJ2cIQxPZQ8asob5ytj1lN7oX8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
	:references:user-agent:mime-version:content-transfer-encoding;
	bh=OAUyf37iUZIf611/kj0iVS0WdmqqhPqTf76z5dMsVCc=;
	b=a07aaa91cwX6c3Pft64VqMI4EJVsC7OS218mW1STsed95bkzQllKSFAsSMNVXhTHf5
	isK+zXmeyT4qZEjr5wttTBNakRdv1oQHHSAYRM8T54aKwsa9DtP/VLDAT1opsOfmAEuW
	JQ8+35E27fxLitbk/GInM3wQvRYimB9Y/oq3r7+v5cwuMqsXFREVpVLeOW/Csl8R916f
	mHaxwYt/gBy5F/JqlK2Hbi2h7XofulrQrEQ7aYvxGPTYoZrnbp7Z5181Dh4hnol1HGTN
	xAH2BXdeBsqTpy8WrHd0lBnvT2Nd8XjEz9VyKUjEDnDSeVltjA43iNR28n7NVi0Htv8K
	sS1Q==
X-Gm-Message-State: APjAAAVwPw8nisr1CvnlrduBVW5r9h62a9EcGgf/8YZmFpyKCbikhVHX
	ZNCBlokZUaXZReYDTq+sQZwJXQ==
X-Google-Smtp-Source: APXvYqy5hGFfJroxJLiyDNqayPSDz7EfaqUlFpOT8zSXAth3atgtw2VqFT5zTk+D2r3ssDBXxiKveQ==
X-Received: by 2002:adf:ee87:: with SMTP id b7mr2523517wro.154.1570622015189; 
	Wed, 09 Oct 2019 04:53:35 -0700 (PDT)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	t123sm2802180wma.40.2019.10.09.04.53.33
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Wed, 09 Oct 2019 04:53:34 -0700 (PDT)
Message-ID: <c0c730e057be4e09d35a85fbcb960a3784c394ed.camel@linuxfoundation.org>
From: richard.purdie@linuxfoundation.org
To: Nicolas Dechesne <nicolas.dechesne@linaro.org>
Date: Wed, 09 Oct 2019 12:53:32 +0100
In-Reply-To: <CAP71WjyAPhw6f+9ZW0NMdzhV-cwWcNc3SLCO74Sv+noXnyX7tA@mail.gmail.com>
References: <20191008184512.20130-1-anibal.limon@linaro.org>
	<47c79ccca81ec9c237357f4a91973d2b6cee77e1.camel@linuxfoundation.org>
	<CAP71WjyAPhw6f+9ZW0NMdzhV-cwWcNc3SLCO74Sv+noXnyX7tA@mail.gmail.com>
User-Agent: Evolution 3.34.0-1 
MIME-Version: 1.0
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
X-List-Received-Date: Wed, 09 Oct 2019 11:53:34 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Wed, 2019-10-09 at 11:02 +0200, Nicolas Dechesne wrote:
> On Wed, Oct 9, 2019 at 1:15 AM <richard.purdie@linuxfoundation.org>
> wrote:
> > On Tue, 2019-10-08 at 13:45 -0500, Aníbal Limón wrote:
> > > In some cases people/organizations are using a SRC_URI with
> > > file:///PATH_TO_DIR that contains a git repository for different
> > > reasons, it is useful when want to do an internal build without
> > > clone sources from outside.
> > > 
> > > This could consume a lot of CPU time because the current taskhash
> > > generation mechanism didn't identify that the folder is a VCS
> > > (git, svn, cvs) and makes the cksum for every file including the
> > > .git repository in this case.
> > > 
> > > There are different ways to improve the situation,
> > > 
> > > * Add protocol=gitscm in file:// SRC_URI but the taskhash is
> > >   calculated before the fetcher identifies the protocol, will
> > > require
> > >   some changes in bitbake codebase.
> > > * This patch: When directory is a git repository (contains .git)
> > >   use HEAD rev + git diff to calculate checksum instead of do it
> > >   in every file, that is hackish because make some assumptions
> > > about
> > >   .git directory contents.
> > > * Variant of this patch: Make a list of VCS directories (.git,
> > > .svn,
> > >   .cvs) and take out for cksum calculations, same as before
> > > making
> > >   assumptions about the . folders content.
> > 
> > This is an interesting one.
> 
> Are you referring to the last bullet here? I suspect it's the second
> one.

Sorry I wasn't clear, I was meaning in general.

> 
> Also to give a bit more background to everyone, as it might not be
> obvious. I've seen the same pattern used several times , especially
> in
> large/corporate deployment of OE/YP. the whole build workspace is
> built as:
> 
> > - sources
> > ---- kernel
> > ---- component_A
> > ---- component_B
> > - layers
> > ---- poky
> > ---- meta-mycompany
> > -------- recipes for kernel, component_A, ...
> 
> The whole workspace is managed with a repo manifest, and the recipes
> are written to use source code from the 'sources' local folder.
> 
> I am not trying to argue whether this is a good practice or not ;-)
> but from the perspectives of the folks I've talked to , there are a
> couple of critical advantages of doing something like that:
> * it looks like Android development workflow ;-)
> * it relates to the company license/legal process and review. e.g.
> all
> the software that gets out of the company is managed by a single repo
> manifest xml file
> * it solves "nicely" the problem of being able to iteratively develop
> using bitbake natively. e.g. "bibtake myimage" always work, and uses
> local changes from 'sources'
> 
> So overall, i am being convinced that this is a valid use case for OE
> end users. I don't think we can use the git:// fetcher as we need the
> snapshot of the current 'sources' (with local changes), and using the
> file:// fetcher has important performance impacts:
> * checksum for 'each' file (which can be large, especially for
> kernel)
> * un-expected rebuild when running repo sync, if any new git objects
> are put in .git (even when no changes are made to the local worktree
> of the git project).
> 
> > File checksums are added to the hashes "late" so that we don't have
> > to
> > reparse entire recipes when files change. We do need a mechanism to
> > know when we need to reparse the checksum. I think this means you
> > can
> > skip the checksum calculation for each file but you do still end up
> > having to stat all files in the tree separately for bitbake's
> > tracking
> > and for git. We also have to notice when new files are added.
> > 
> > As such I'm not convinced this patch will work correctly (e.g.
> > would it
> > notice if I copy in a new file to the directory untracked by git).
> 
> At least I confirm that with the file:// fetcher everything works
> fine, when modifying files. I don't think I have tried adding new
> files. But I will try that.

I'd like to check that bitbake's hashes are changing correctly in the
different modification cases.

I did also wondering about this kind of trick, borrowed from stack
overflow:

if [ ! -e  .git/allfilesindex ]; then
    cp .git/index .git/allfilesindex
fi
GIT_INDEX_FILE=.git/allfilesindex git add -u; git write-tree

to get a hash which represents the state of the tree. Using git add -A
might track untracked files too.

> Are you trying to say that to fix this properly we might need another
> Fetcher , something in between file:// and git://, e.g. localgit://?
> Would that make this problem easier to solve?

I'm not sure about that. I'm mainly worried that we have reports that
file:// doesn't work correctly today before we add this kind of
complexity on top. Hence my comments about needing better tests in this
area, with and without git involved.

I'm a little bit too focused on the release to be able to think clearly
about this right now which doesn't help.

Cheers,

Richard

> > A first step may be to add some further tests to bitbake-selftest
> > to
> > better cover this area...
> > 
> > Cheers,
> > 
> > Richard
> > 
> > 
> > 
> > 
> > 



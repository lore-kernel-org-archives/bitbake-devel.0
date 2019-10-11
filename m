Return-Path: <ola.x.nilsson@axis.com>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
	by mail.openembedded.org (Postfix) with ESMTP id E62BD7F59B
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 11 Oct 2019 12:36:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bastet.se.axis.com (Postfix) with ESMTP id 956E0184EC;
	Fri, 11 Oct 2019 14:36:08 +0200 (CEST)
X-Axis-User: NO
X-Axis-NonUser: YES
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id drih_otYJ-rC; Fri, 11 Oct 2019 14:36:07 +0200 (CEST)
Received: from boulder03.se.axis.com (boulder03.se.axis.com [10.0.8.17])
	by bastet.se.axis.com (Postfix) with ESMTPS id 7E89918107;
	Fri, 11 Oct 2019 14:36:07 +0200 (CEST)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 54F091E081;
	Fri, 11 Oct 2019 14:36:07 +0200 (CEST)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 492001E07F;
	Fri, 11 Oct 2019 14:36:07 +0200 (CEST)
Received: from thoth.se.axis.com (unknown [10.0.2.173])
	by boulder03.se.axis.com (Postfix) with ESMTP;
	Fri, 11 Oct 2019 14:36:07 +0200 (CEST)
Received: from XBOX02.axis.com (xbox02.axis.com [10.0.5.16])
	by thoth.se.axis.com (Postfix) with ESMTP id 3CD55311B;
	Fri, 11 Oct 2019 14:36:07 +0200 (CEST)
Received: from XBOX02.axis.com (10.0.5.16) by XBOX02.axis.com (10.0.5.16) with
	Microsoft SMTP Server (TLS) id 15.0.1365.1;
	Fri, 11 Oct 2019 14:36:06 +0200
Received: from lnxolani1 (10.0.5.60) by xbox02.axis.com (10.0.5.16) with
	Microsoft SMTP Server id 15.0.1365.1 via Frontend Transport;
	Fri, 11 Oct 2019 14:36:06 +0200
References: <20191008184512.20130-1-anibal.limon@linaro.org>
	<47c79ccca81ec9c237357f4a91973d2b6cee77e1.camel@linuxfoundation.org>
	<CAP71WjyAPhw6f+9ZW0NMdzhV-cwWcNc3SLCO74Sv+noXnyX7tA@mail.gmail.com>
	<c0c730e057be4e09d35a85fbcb960a3784c394ed.camel@linuxfoundation.org>
User-agent: mu4e 1.0; emacs 27.0.50
From: Ola x Nilsson <ola.x.nilsson@axis.com>
To: "richard.purdie@linuxfoundation.org" <richard.purdie@linuxfoundation.org>
In-Reply-To: <c0c730e057be4e09d35a85fbcb960a3784c394ed.camel@linuxfoundation.org>
Date: Fri, 11 Oct 2019 14:36:06 +0200
Message-ID: <jwq1rvjwjbd.fsf@axis.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
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
X-List-Received-Date: Fri, 11 Oct 2019 12:36:10 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable


On Wed, Oct 09 2019, richard.purdie@linuxfoundation.org wrote:

> On Wed, 2019-10-09 at 11:02 +0200, Nicolas Dechesne wrote:
>> On Wed, Oct 9, 2019 at 1:15 AM <richard.purdie@linuxfoundation.org>
>> wrote:
>> > On Tue, 2019-10-08 at 13:45 -0500, An=C3=ADbal Lim=C3=B3n wrote:
>> > > In some cases people/organizations are using a SRC_URI with
>> > > file:///PATH_TO_DIR that contains a git repository for different
>> > > reasons, it is useful when want to do an internal build without
>> > > clone sources from outside.
>> > >=20
>> > > This could consume a lot of CPU time because the current taskhash
>> > > generation mechanism didn't identify that the folder is a VCS
>> > > (git, svn, cvs) and makes the cksum for every file including the
>> > > .git repository in this case.
>> > >=20
>> > > There are different ways to improve the situation,
>> > >=20
>> > > * Add protocol=3Dgitscm in file:// SRC_URI but the taskhash is
>> > >   calculated before the fetcher identifies the protocol, will
>> > > require
>> > >   some changes in bitbake codebase.
>> > > * This patch: When directory is a git repository (contains .git)
>> > >   use HEAD rev + git diff to calculate checksum instead of do it
>> > >   in every file, that is hackish because make some assumptions
>> > > about
>> > >   .git directory contents.
>> > > * Variant of this patch: Make a list of VCS directories (.git,
>> > > .svn,
>> > >   .cvs) and take out for cksum calculations, same as before
>> > > making
>> > >   assumptions about the . folders content.
>> >=20
>> > This is an interesting one.
>>=20
>> Are you referring to the last bullet here? I suspect it's the second
>> one.
>
> Sorry I wasn't clear, I was meaning in general.
>
>>=20
>> Also to give a bit more background to everyone, as it might not be
>> obvious. I've seen the same pattern used several times , especially
>> in
>> large/corporate deployment of OE/YP. the whole build workspace is
>> built as:
>>=20
>> > - sources
>> > ---- kernel
>> > ---- component_A
>> > ---- component_B
>> > - layers
>> > ---- poky
>> > ---- meta-mycompany
>> > -------- recipes for kernel, component_A, ...
>>=20
>> The whole workspace is managed with a repo manifest, and the recipes
>> are written to use source code from the 'sources' local folder.
>>=20
>> I am not trying to argue whether this is a good practice or not ;-)
>> but from the perspectives of the folks I've talked to , there are a
>> couple of critical advantages of doing something like that:
>> * it looks like Android development workflow ;-)
>> * it relates to the company license/legal process and review. e.g.
>> all
>> the software that gets out of the company is managed by a single repo
>> manifest xml file
>> * it solves "nicely" the problem of being able to iteratively develop
>> using bitbake natively. e.g. "bibtake myimage" always work, and uses
>> local changes from 'sources'
>>=20
>> So overall, i am being convinced that this is a valid use case for OE
>> end users. I don't think we can use the git:// fetcher as we need the
>> snapshot of the current 'sources' (with local changes), and using the
>> file:// fetcher has important performance impacts:
>> * checksum for 'each' file (which can be large, especially for
>> kernel)
>> * un-expected rebuild when running repo sync, if any new git objects
>> are put in .git (even when no changes are made to the local worktree
>> of the git project).
>>=20
>> > File checksums are added to the hashes "late" so that we don't have
>> > to
>> > reparse entire recipes when files change. We do need a mechanism to
>> > know when we need to reparse the checksum. I think this means you
>> > can
>> > skip the checksum calculation for each file but you do still end up
>> > having to stat all files in the tree separately for bitbake's
>> > tracking
>> > and for git. We also have to notice when new files are added.
>> >=20
>> > As such I'm not convinced this patch will work correctly (e.g.
>> > would it
>> > notice if I copy in a new file to the directory untracked by git).
>>=20
>> At least I confirm that with the file:// fetcher everything works
>> fine, when modifying files. I don't think I have tried adding new
>> files. But I will try that.
>
> I'd like to check that bitbake's hashes are changing correctly in the
> different modification cases.
>
> I did also wondering about this kind of trick, borrowed from stack
> overflow:
>
> if [ ! -e  .git/allfilesindex ]; then
>     cp .git/index .git/allfilesindex
> fi
> GIT_INDEX_FILE=3D.git/allfilesindex git add -u; git write-tree
>
> to get a hash which represents the state of the tree. Using git add -A
> might track untracked files too.

This is what externalsrc.bbclass does to detect changes.

/Ola

>> Are you trying to say that to fix this properly we might need another
>> Fetcher , something in between file:// and git://, e.g. localgit://?
>> Would that make this problem easier to solve?
>
> I'm not sure about that. I'm mainly worried that we have reports that
> file:// doesn't work correctly today before we add this kind of
> complexity on top. Hence my comments about needing better tests in this
> area, with and without git involved.
>
> I'm a little bit too focused on the release to be able to think clearly
> about this right now which doesn't help.
>
> Cheers,
>
> Richard
>
>> > A first step may be to add some further tests to bitbake-selftest
>> > to
>> > better cover this area...
>> >=20
>> > Cheers,
>> >=20
>> > Richard
>> >=20
>> >=20
>> >=20
>> >=20
>> >=20


--=20
Ola x Nilsson


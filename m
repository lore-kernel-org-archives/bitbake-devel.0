Return-Path: <armccurdy@gmail.com>
Received: from mail-wm0-f46.google.com (mail-wm0-f46.google.com [74.125.82.46])
	by mail.openembedded.org (Postfix) with ESMTP id 977127848B
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 25 Aug 2017 22:11:01 +0000 (UTC)
Received: by mail-wm0-f46.google.com with SMTP id b189so1398443wmd.0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 25 Aug 2017 15:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=knI1JOpAKBcp5pbc52/IGtXpqdKtS3Dp8BpzsqQUR4k=;
	b=A0+r7Wab/yOCoTf9en+OmlT3pCkl5sBP8OdaCLtUnTAvNw8wFZzQDRzBe/CbINQv18
	esf31XSnu9HDvi0vaTKxgMLJYqghAwmhw6bTAomNKWbRCYq5lj903g5zSUDTFGc3i0hB
	zYSpRn+LCVwOoTpECJ69hc/SDy4p7Jc+ZgSCejqskakDJolUUb6eG54L96nW/QyqUpw/
	0eL/P1U3HGgrEQUvdvhSzufmyc7p5S2AJNMi+jnm5lfaV4PPp0QP1NMm2VytRpNCXfRx
	qwZJ2DUqjp3zwbFsMplOMkgyUlDRgLA5ze3IqvIIHUkUT0FI8aLSlRiIqV0kru/XeB6a
	0w4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=knI1JOpAKBcp5pbc52/IGtXpqdKtS3Dp8BpzsqQUR4k=;
	b=s16yw220/gpYZE0BDo8Cx3bZ2kq1n24ZQLau1umHTxe095lbPCZVCR2mMyF8VpnPS0
	TpxvnbGHcpZnoqH8TWBv5rQxvD02k4DLvVDwPg8eVWlxB352AxPQyxgTwmWUYel/61DM
	Z/sJeFNNmYqo9YUPC2Zx52oQ/JGaoilGwD+cqR/oFcdzQIHaBE81fkTHMFcEi+YfAaTa
	y3PSgrFJrK5mPfKs2bLUZevoD9Bs+y1tVRU+jTjbzYdXv3JyaFtsOWzHX65QXoQ6Hksw
	RvBOgKnHlPJFXX3qV58EF1II0v0bPkiAtU1rSMjwoOyeSZ13bBQlbN+brYZe5/7qOwVI
	WL2Q==
X-Gm-Message-State: AHYfb5gL5mOX/79wtwE2S2gBFiupfJsymjhncD9aJTxTEHUlBv8XWm3n
	ua80iBYOpLsWdK7tS4KsXbSvHB5fmQ==
X-Received: by 10.28.182.7 with SMTP id g7mr373997wmf.66.1503699062611; Fri,
	25 Aug 2017 15:11:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.223.169.70 with HTTP; Fri, 25 Aug 2017 15:11:02 -0700 (PDT)
In-Reply-To: <3770d520be40403793f4021194082856@SGPMBX1024.APAC.bosch.com>
References: <3770d520be40403793f4021194082856@SGPMBX1024.APAC.bosch.com>
From: Andre McCurdy <armccurdy@gmail.com>
Date: Fri, 25 Aug 2017 15:11:02 -0700
Message-ID: <CAJ86T=WOAXeYV6iSsUaTBs8oHy6RV_zjg6reTn3P_m=y7BqSLQ@mail.gmail.com>
To: "GUAN Ben (ST-FIR/ENG1-Zhu)" <Ben.Guan@cn.bosch.com>
Cc: "Jonas Mark \(ST-FIR/ENG1\)" <Mark.Jonas@de.bosch.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: How to detect change on a repo manifest.git and rebuild the recipe with "repo://"
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
X-List-Received-Date: Fri, 25 Aug 2017 22:11:01 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 24, 2017 at 7:06 PM, GUAN Ben (ST-FIR/ENG1-Zhu)
<Ben.Guan@cn.bosch.com> wrote:
> The source code of my SW consist of multiple components from different
> repository, which is managed by a repo manifest repository. So I want to =
use
> =E2=80=9Crepo://=E2=80=9D for the repo manifest repository instead of mul=
tiple =E2=80=9Cgit://=E2=80=9D to
> include all repositories in the SRC_URI.
>
> I add the following to MyRecipe_git.bb:
> ```
> SRC_URI =3D =E2=80=9Crepo://git@<MY_HOST>/manifest.git;protocol=3Dssh;bra=
nch=3Dmaster=E2=80=9D
>
> Now I can build my recipe with Yocto, but there is an issue:  When there =
is
> any change required in the repositories of my application, I will change =
the
> code and update the tags in default.xml of manifest.git. I want Yocto cou=
ld
> detect this change, fetch the change, them rebuild the recipe.
>
> With =E2=80=9Cgit://=E2=80=9D, it is easy to achieve via setting =E2=80=
=9C${AUTOREV}=E2=80=9D to =E2=80=9CSRCREV=E2=80=9D.
> But the fetch2.repo doesn=E2=80=99t support SRCREV. I have go through the=
 existing
> recipe within meta-oe and oe-core, no recipe is using =E2=80=9Crepo://=E2=
=80=9D.
>
> Does anybody have experience about it and help? Thank you in advance.

Right, the repo fetcher doesn't support SRCREV. It's not even clear
how a repo manifest could map to a SRCREV, since the manifest could
define an arbitrary combination of fixed revisions and/or branches for
an arbitrary number of git repos.

You could perhaps append a call to "repo sync" to the do_patch etc
task in your recipe but it would certainly be a hack and you would run
into dependency problems (do_patch might not be re-run and without a
SRCREV bitbake wouldn't know if/when the code had changed and
therefore if/when to re-run dependent tasks).

As you have discovered by looking oe-core and meta-oe, the repo
fetcher isn't used much. The preferred solution for recipes which need
to fetch from multiple git repos is to include multiple git://
references in SRC_URI.


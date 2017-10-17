Return-Path: <freesilicon@gmail.com>
Received: from mail-wm0-f67.google.com (mail-wm0-f67.google.com [74.125.82.67])
	by mail.openembedded.org (Postfix) with ESMTP id D787F7821B
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 17 Oct 2017 11:59:11 +0000 (UTC)
Received: by mail-wm0-f67.google.com with SMTP id q124so3376481wmb.0
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 17 Oct 2017 04:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=g7kTtWpJDPGYFGRATOFSCempQQZQuVk1vr5dhlDutmc=;
	b=IcOW8WXkkNXyDn1Q1kULoxyv6XdGsRBA28bvtU6vJxXGTBO9ZCReYbYuqvXMA+ULyE
	TxO+e2VxCFQo8nlfadtBqGWW43W3tTiGrWw0staNP2Eic3IF2rPEmbrBknxEycX6QIfV
	/jDWI/CwynFay6ujnQiqV7UVqKWxxVG2PeqXB7a7zvqbX8ItklbU7nSbEOp+iPi/fdq4
	6hj97Xr7DE8sA3StsOf0wNgVatvKlpcXLZcScWnIdK4Vc/GOEIPkejH0zVWdhsO5z61U
	m1vsGVUlQ5mTTCp38L6XdpUVOEAFbMJlZEH7pElTrVarhYSbo7mD/O9CsMthB+LalHdz
	w91g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=g7kTtWpJDPGYFGRATOFSCempQQZQuVk1vr5dhlDutmc=;
	b=N83EtsK8A/Kv/0TWn3BlPmLT3lC0XXKSb4QtF2VAGizvJUFkAYt6td+EQgLmcP8Wmx
	EupeuuYrv7L4JVeg+AuQ+AeBpxPQ8DWC5uoBgegPJx15ddEEaX/lgbRUk3KOi8E/hzsR
	cqZL4GdHtXgsX2sh/sRp52QHlD6/yYTs4PgCxstGQPgnsZPK+ss7yW1Eqg6edt0FL16T
	T3+TJ/0nL3o9/IBgiAmbI7KiWgcjLb5WE37sd9kwjlRubkddv1xFdE0bFSVLWnNZMLHc
	YiyZ904XU6RiifNDSXcvI05XLldSTx1W1NP8eP0/OCw1M8aLuQc+8tqUexYxPczkLOtF
	I7bQ==
X-Gm-Message-State: AMCzsaVG7mu3pi/SW2wNrYDvoBNwIMFIbL63bZlXTmTI1AcpQ0vNEGMe
	Ztqq/OGHAYfF7vrxeK5WFvw=
X-Google-Smtp-Source: ABhQp+Q8yRD+9XB8UBC6ob1KrXE4GaOd7vUiwx43vxKUGlEvXxTNkpsneoV/3mHRIx3SRA8HQJmlvw==
X-Received: by 10.28.109.28 with SMTP id i28mr3701683wmc.67.1508241552606;
	Tue, 17 Oct 2017 04:59:12 -0700 (PDT)
Received: from crde-port-20.cahors.local ([185.47.80.46])
	by smtp.gmail.com with ESMTPSA id
	p20sm10224618wma.0.2017.10.17.04.59.11
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 17 Oct 2017 04:59:12 -0700 (PDT)
From: David Vincent <freesilicon@gmail.com>
To: Alexander Kanavin <alexander.kanavin@linux.intel.com>
Date: Tue, 17 Oct 2017 13:59:04 +0200
Message-ID: <5556941.pslUcQMuWo@crde-port-20.cahors.local>
In-Reply-To: <612b6e16-2db3-4e33-45fa-e03cb6d26dc1@linux.intel.com>
References: <20171017112748.10968-1-freesilicon@gmail.com>
	<612b6e16-2db3-4e33-45fa-e03cb6d26dc1@linux.intel.com>
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] fetch/git: fix per-branch unpacking
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
X-List-Received-Date: Tue, 17 Oct 2017 11:59:12 -0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

On mardi 17 octobre 2017 13:26:03 CEST Alexander Kanavin wrote:
> On 10/17/2017 02:27 PM, David Vincent wrote:
> > Create branches for each user-supplied name when running checkout and
> > set start point of branch to the resolved revision.
>=20
> Can you provide an example of how this should be used please (in the
> commit message)?
>=20
> Alex
=46irst of all, sorry for the multipost, I resent the patch too quickly aft=
er=20
seeing the mailman notification.

I don't clearly see the example I need to provide since this behavior is=20
already documented in the fetcher and this patch is simply a bugfix :

=2D branch
   The git branch to retrieve from. The default is "master"

   This option also supports multiple branch fetching, with branches
   separated by commas.  In multiple branches case, the name option
   must have the same number of names to match the branches, which is
   used to specify the SRC_REV for the branch
   e.g:
   SRC_URI=3D"git://some.host/somepath;branch=3DbranchX,branchY;name=3Dname=
X,nameY"
   SRCREV_nameX =3D "xxxxxxxxxxxxxxxxxxxx"
   SRCREV_nameY =3D =E2=80=9CYYYYYYYYYYYYYYYYYYYY=E2=80=9D

Maybe I can provide some background behind this fix and you tell me if I mu=
st=20
complete my commit message.
When working on a linux-yocto kernel, I tried to merge a feature branch in =
my=20
machine branch using the merge functionality, therefore I needed to checkou=
t=20
two branches in a specific revision. Problem is that my machine branch was=
=20
correctly checked out with the SRCREV provided in the recipe but the featur=
e=20
branch was not, it was checked out to the tip of the remote branch. When=20
investigating a little further, I did find that bitbake only checks out the=
=20
first branch and does not handle other branches (why it did work in the fir=
st=20
place seems like some bbclass magic to me). The point is that with this pat=
ch,=20
all my branches are correctly checked out and my kernel got the good revisi=
on.

=2D-
David


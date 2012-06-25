Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Peter.Seebach@windriver.com>) id 1Sj2CT-0004Go-AJ
	for bitbake-devel@lists.openembedded.org;
	Mon, 25 Jun 2012 07:51:01 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail1.windriver.com (8.14.3/8.14.3) with ESMTP id q5P5dvLs028194
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Sun, 24 Jun 2012 22:39:57 -0700 (PDT)
Received: from wrlaptop (172.25.40.226) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.1.255.0;
	Sun, 24 Jun 2012 22:39:57 -0700
Date: Mon, 25 Jun 2012 00:39:41 -0500
From: Peter Seebach <peter.seebach@windriver.com>
To: "Xu, Dongxiao" <dongxiao.xu@intel.com>
Message-ID: <20120625003941.798e4914@wrlaptop>
In-Reply-To: <40776A41FC278F40B59438AD47D147A90FDA26A2@SHSMSX102.ccr.corp.intel.com>
References: <752ca278.1ab5.138076d8860.Coremail.scanli@126.com>
	<40776A41FC278F40B59438AD47D147A90FDA26A2@SHSMSX102.ccr.corp.intel.com>
X-Mailer: Claws Mail 3.8.0 (GTK+ 2.24.4; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>,
	=?UTF-8?B?5p2O6YeR5oiQ?= <scanli@126.com>
Subject: Re: Hob can't support external toolchain?
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Mon, 25 Jun 2012 05:51:01 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 25 Jun 2012 00:51:08 +0000
"Xu, Dongxiao" <dongxiao.xu@intel.com> wrote:

> Well, we met the same error (No GNU_HASH in the elf binary) even with
> command line. The different is that we failed on =E2=80=9Czip=E2=80=9D re=
cipe.

There are a number of packages which do not pass --hash-style=3Dgnu to
the linker correctly.  With the native toolchain, this doesn't matter
because it's the default.  With the CS toolchain, you either need a
bunch of INSANE_SKIP_rpmname =3D "ldflags" or to get a build that's been
modified to enable GNU_HASH by default.

-s
--=20
Listen, get this.  Nobody with a good compiler needs to be justified.



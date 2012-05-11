Received: from ch1ehsobe004.messaging.microsoft.com ([216.32.181.184]
	helo=ch1outboundpool.messaging.microsoft.com)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <B29882@freescale.com>) id 1SSrNh-0006Yx-MR
	for bitbake-devel@lists.openembedded.org;
	Fri, 11 May 2012 17:03:45 +0200
Received: from mail162-ch1-R.bigfish.com (10.43.68.248) by
	CH1EHSOBE014.bigfish.com (10.43.70.64) with Microsoft SMTP Server id
	14.1.225.23; Fri, 11 May 2012 14:08:27 +0000
Received: from mail162-ch1 (localhost [127.0.0.1])	by
	mail162-ch1-R.bigfish.com (Postfix) with ESMTP id 461012A0215;
	Fri, 11 May 2012 14:08:27 +0000 (UTC)
X-SpamScore: -9
X-BigFish: VS-9(zz9371I1432N98dKzz1202hzz8275bh8275dhz2dh2a8h668h839h8e2h8e3hbe9i)
X-Forefront-Antispam-Report: CIP:70.37.183.190; KIP:(null); UIP:(null); IPV:NLI;
	H:mail.freescale.net; RD:none; EFVD:NLI
Received: from mail162-ch1 (localhost.localdomain [127.0.0.1]) by mail162-ch1
	(MessageSwitch) id 133674530525030_16397;
	Fri, 11 May 2012 14:08:25 +0000 (UTC)
Received: from CH1EHSMHS018.bigfish.com (snatpool1.int.messaging.microsoft.com
	[10.43.68.240])	by mail162-ch1.bigfish.com (Postfix) with ESMTP id
	001264A005A;	Fri, 11 May 2012 14:08:24 +0000 (UTC)
Received: from mail.freescale.net (70.37.183.190) by CH1EHSMHS018.bigfish.com
	(10.43.70.18) with Microsoft SMTP Server (TLS) id 14.1.225.23;
	Fri, 11 May 2012 14:08:23 +0000
Received: from 039-SN1MPN1-002.039d.mgd.msft.net ([169.254.2.151]) by
	039-SN1MMR1-003.039d.mgd.msft.net ([10.84.1.16]) with mapi id
	14.01.0355.003; Fri, 11 May 2012 09:08:23 -0500
From: McClintock Matthew-B29882 <B29882@freescale.com>
To: GOPIKRISHNAN S <gopikrishnans@pec.edu>
Thread-Topic: [bitbake-devel] QorIQ_SDK-20110709-systembuilder
Thread-Index: AQHNL3+GXqxiC57IcUWb3DVocMVk5g==
Date: Fri, 11 May 2012 14:08:23 +0000
Message-ID: <CAEsOVNevK-azVHFHNZj4OHz7O94x7SqeS5OOp7K9jUFWOhAwSA@mail.gmail.com>
References: <CAOkC3RZ_mRLa8pmPEJKx-Qx=EfLN-Y8Ffsuchm_bAZ9gLGdpSQ@mail.gmail.com>
In-Reply-To: <CAOkC3RZ_mRLa8pmPEJKx-Qx=EfLN-Y8Ffsuchm_bAZ9gLGdpSQ@mail.gmail.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [99.47.177.27]
MIME-Version: 1.0
X-OriginatorOrg: freescale.com
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: QorIQ_SDK-20110709-systembuilder
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
Reply-To: McClintock Matthew-B29882 <B29882@freescale.com>
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 11 May 2012 15:03:46 -0000
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <E99CFA2E6D7C2B4BBFA8A66612817ADF@mgd.freescale.com>
Content-Transfer-Encoding: quoted-printable

You should contact Freescale support.

support@freescale.com

-M

On Fri, May 11, 2012 at 1:46 AM, GOPIKRISHNAN S <gopikrishnans@pec.edu> wro=
te:
> Hello,
>
> =A0=A0=A0=A0=A0=A0 I am n newbie working on QorIQ_SDK-20110709-systembuil=
der +
> Patches_V1_03_20110929;
>
>
> =A0=A0=A0 * I have installed clamav using
>
> =A0=A0=A0=A0 # echo "PROJECT_EXTRA_PKGS +=3D \clamav"\" >
> /mycollection/recipies/images/amend.inc
>
> =A0=A0=A0 Its installed. When I tried installing dpkg using same procedur=
e; I got
> error message as below
> =A0=A0=A0 # echo "PROJECT_EXTRA_PKGS +=3D \dpkg"\" >
> /mycollection/recipies/images/amend.inc
>
> gopi@gopi-desktop:/media/325GB_Drive/fs_dev/p2020_20110709$ bitbake
> devel-image
> NOTE: Handling BitBake files: | (0386/0386) [100 %]
> Parsing of 386 .bb files complete (380 cached, 6 parsed). 515 targets, 1
> skipped, 0 masked, 0 errors.
> ERROR:
> '['/media/325GB_Drive/fs_dev/p2020_20110709/sb-core/recipes/images/devel-=
image.bb']'
> RDEPENDS/RRECOMMENDS or otherwise requires the runtime entity 'dpkg' but =
it
> wasn't found in any PACKAGE or RPROVIDES variables
> ERROR: Required build target 'devel-image' has no buildable providers.
> Missing or unbuildable dependency chain was: ['devel-image', 'dpkg']
> NOTE: Resolving any missing task queue dependencies
> ERROR:
> '['/media/325GB_Drive/fs_dev/p2020_20110709/sb-core/recipes/images/devel-=
image.bb']'
> RDEPENDS/RRECOMMENDS or otherwise requires the runtime entity 'dpkg' but =
it
> wasn't found in any PACKAGE or RPROVIDES variables
> Unknown Event: <bb.event.NoProvider instance at 0x9e0ecec>
> NOTE: Runtime target 'dpkg' is unbuildable, removing...
> Missing or unbuildable dependency chain was: ['dpkg']
> ERROR: Required build target 'devel-image' has no buildable providers.
> Missing or unbuildable dependency chain was: ['devel-image', 'dpkg']
> Command execution failed: Traceback (most recent call last):
> =A0 File
> "/media/325GB_Drive/fs_dev/p2020_20110709/scripts/bitbake/lib/bb/command.=
py",
> line 88, in runAsyncCommand
> =A0=A0=A0 commandmethod(self.cmds_async, self, options)
> =A0 File
> "/media/325GB_Drive/fs_dev/p2020_20110709/scripts/bitbake/lib/bb/command.=
py",
> line 174, in buildTargets
> =A0=A0=A0 command.cooker.buildTargets(pkgs_to_build, task)
> =A0 File
> "/media/325GB_Drive/fs_dev/p2020_20110709/scripts/bitbake/lib/bb/cooker.p=
y",
> line 784, in buildTargets
> =A0=A0=A0 taskdata.add_unresolved(localdata, self.status)
> =A0 File
> "/media/325GB_Drive/fs_dev/p2020_20110709/scripts/bitbake/lib/bb/taskdata=
.py",
> line 562, in add_unresolved
> =A0=A0=A0 self.remove_runtarget(self.getrun_id(target))
> =A0 File
> "/media/325GB_Drive/fs_dev/p2020_20110709/scripts/bitbake/lib/bb/taskdata=
.py",
> line 535, in remove_runtarget
> =A0=A0=A0 self.fail_fnid(fnid, missing_list)
> =A0 File
> "/media/325GB_Drive/fs_dev/p2020_20110709/scripts/bitbake/lib/bb/taskdata=
.py",
> line 490, in fail_fnid
> =A0=A0=A0 self.remove_buildtarget(target, missing_list)
> =A0 File
> "/media/325GB_Drive/fs_dev/p2020_20110709/scripts/bitbake/lib/bb/taskdata=
.py",
> line 519, in remove_buildtarget
> =A0=A0=A0 raise bb.providers.NoProvider
> NoProvider
>
>
> Where I should provide the configurations/specification for source...
>
>
>
>
> Reg,
> Gopi Krishnan S
>
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel
>=




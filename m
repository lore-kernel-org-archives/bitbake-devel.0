Received: from mail-yx0-f175.google.com ([209.85.213.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <cliff.brake@gmail.com>) id 1RAfJI-00089p-Q6
	for bitbake-devel@lists.openembedded.org;
	Mon, 03 Oct 2011 11:59:44 +0200
Received: by yxj17 with SMTP id 17so3234369yxj.6
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 03 Oct 2011 02:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=mime-version:date:message-id:subject:from:to:content-type
	:content-transfer-encoding;
	bh=tDZDfKd3Tqoz2Vn69Vnnj6ln4pFueSF4XuqGmfK1UaI=;
	b=Vk90CbBtYGNndTeEfGc7RPg8WRk23cpysGIJi2HL7o/tgFF/T9mutb9uuW+nxFH6kY
	+CT15TCAsSOp5t+LzNnUcpRRduyUJTOGwcE2hAgf1a4F+9K1f+4tzZvdiRfYwjjfe5cg
	DwSAoOxKr6AwHhhKOy5F4PkeVJAGjPjhhS18c=
MIME-Version: 1.0
Received: by 10.236.77.233 with SMTP id d69mr84895661yhe.84.1317635651874;
	Mon, 03 Oct 2011 02:54:11 -0700 (PDT)
Received: by 10.236.209.97 with HTTP; Mon, 3 Oct 2011 02:54:11 -0700 (PDT)
Date: Mon, 3 Oct 2011 05:54:11 -0400
Message-ID: <CAOd_LFywLRNDRAbWLJvV1Z1qE4Swot0SQT2RpNz-CBWPc9Jdmg@mail.gmail.com>
From: Cliff Brake <cliff.brake@gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: fetcher hangs
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
X-List-Received-Date: Mon, 03 Oct 2011 09:59:45 -0000
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

One thing I've been noticing is that bitbake seems to hang when its
trying to fetch a dead URI:

NOTE: package linux-3.0-r4: task do_fetch: Started
WARNING: Fetcher failure for URL: 'None'. Fetch command export
HOME=3D"/home/cbrake"; export SSH_AGENT_PID=3D"2994"; export
SSH_AUTH_SOCK=3D"/tmp/keyring-ptLxSd/ssh"; export
GIT_CONFIG=3D"/scratch/pp/pp-oe-2011/build/tmp-angstrom_2010_x-eglibc/sysro=
ots/x86_64-linux/usr/etc/gitconfig";
export PATH=3D"/scratch/pp/pp-oe-2011/build/tmp-angstrom_2010_x-eglibc/sysr=
oots/x86_64-linux/usr/bin/armv5te-angstrom-linux-gnueabi:/scratch/pp/pp-oe-=
2011/build/tmp-angstrom_2010_x-eglibc/sysroots/cm-x270/usr/bin/crossscripts=
:/scratch/pp/pp-oe-2011/build/tmp-angstrom_2010_x-eglibc/sysroots/x86_64-li=
nux/usr/sbin:/scratch/pp/pp-oe-2011/build/tmp-angstrom_2010_x-eglibc/sysroo=
ts/x86_64-linux/usr/bin:/scratch/pp/pp-oe-2011/build/tmp-angstrom_2010_x-eg=
libc/sysroots/x86_64-linux/sbin:/scratch/pp/pp-oe-2011/build/tmp-angstrom_2=
010_x-eglibc/sysroots/x86_64-linux//bin:/scratch/pp/pp-oe-2011/build/tmp-an=
gstrom_2010_x-eglibc/sysroots/x86_64-linux/usr/bin/armv5te-angstrom-linux-g=
nueabi:/scratch/pp/pp-oe-2011/build/tmp-angstrom_2010_x-eglibc/sysroots/x86=
_64-linux/usr/bin:/scratch/pp/pp-oe-2011/sources/openembedded-core/scripts:=
/scratch/pp/pp-oe-2011/sources/bitbake/bin:/home/cbrake/bin:/usr/local/sbin=
:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/scratch/pp/pp-oe-=
2011/sources/openembedded-core/scripts";
/usr/bin/env wget -t 5 -q --passive-ftp --no-check-certificate -P
/scratch/pp/pp-oe-2011/sources/downloads
'http://kernel.org/pub/linux/kernel/v3.0/linux-3.0.tar.bz2' failed
with signal 8, output:
(bitbake hangs here)

Is this expected behavior?

Thanks,
Cliff

--=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
http://bec-systems.com



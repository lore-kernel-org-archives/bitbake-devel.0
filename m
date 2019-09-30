Return-Path: <houssem.chaabani@sofia-technologies.com>
X-Greylist: delayed 8400 seconds by postgrey-1.34 at layers.openembedded.org;
	Mon, 30 Sep 2019 16:57:49 UTC
Received: from 8.mo7.mail-out.ovh.net (8.mo7.mail-out.ovh.net [46.105.77.114])
	by mail.openembedded.org (Postfix) with ESMTP id A7FEA7F2FA
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 30 Sep 2019 16:57:49 +0000 (UTC)
Received: from player157.ha.ovh.net (unknown [10.108.57.38])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id 0681B13514A
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 30 Sep 2019 16:29:54 +0200 (CEST)
Received: from RCM-web1.webmail.mail.ovh.net (unknown [41.226.168.190])
	(Authenticated sender: houssem.chaabani@sofia-technologies.com)
	by player157.ha.ovh.net (Postfix) with ESMTPSA id B4835A5466B2
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 30 Sep 2019 14:29:54 +0000 (UTC)
MIME-Version: 1.0
Date: Mon, 30 Sep 2019 15:29:54 +0100
From: houssem.chaabani@sofia-technologies.com
To: bitbake-devel@lists.openembedded.org
Message-ID: <4b8fe9596d1e1dae1f37cca59d71b113@sofia-technologies.com>
X-Sender: houssem.chaabani@sofia-technologies.com
User-Agent: Roundcube Webmail/1.3.10
X-Originating-IP: 41.226.168.190
X-Webmail-UserID: houssem.chaabani@sofia-technologies.com
X-Ovh-Tracer-Id: 1252563647244634430
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrgedvgdejgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecu
X-Mailman-Approved-At: Tue, 01 Oct 2019 21:28:02 +0000
Subject: error while building SPB228 USB driver
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
X-List-Received-Date: Mon, 30 Sep 2019 16:57:49 -0000
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I am adding SPB228 driver to an raspberry image and a got an error while 
compiling:

ERROR: linux-sdio-driver-228-1.0-r0 do_compile: oe_runmake failed
ERROR: linux-sdio-driver-228-1.0-r0 do_compile: Function failed: 
do_compile (log file is located at 
/home/houssem/poky/build/tmp/work/raspberrypi3-poky-linux-gnueabi/linux-sdio-driver-228/1.0-r0/temp/log.do_compile.7259)
ERROR: Logfile of failure stored in: 
/home/houssem/poky/build/tmp/work/raspberrypi3-poky-linux-gnueabi/linux-sdio-driver-228/1.0-r0/temp/log.do_compile.7259
.
.
.
.
ERROR: Task 
(/home/houssem/meta-spb228-sdio/recipes-kernel/spb228-sdio/linux-sdio-driver-228.bb:do_compile) 
failed with exit code '1'



if there is a solution it will be very helpful.

Best regards
Houssem


Return-Path: <florian.doersch@iis.fraunhofer.de>
X-Greylist: delayed 378 seconds by postgrey-1.34 at layers.openembedded.org;
	Fri, 09 Jun 2017 10:40:05 UTC
Received: from mx-relay12-hz1.antispameurope.com
	(mx-relay12-hz1.antispameurope.com [94.100.132.212])
	by mail.openembedded.org (Postfix) with ESMTP id C57B271AEB
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  9 Jun 2017 10:40:05 +0000 (UTC)
Received: from mailgw1.iis.fraunhofer.de ([153.96.172.4]) by
	mx-relay12-hz1.antispameurope.com; Fri, 09 Jun 2017 12:33:44 +0200
Received: from mail.iis.fraunhofer.de (mail03.iis.fhg.de [153.96.171.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by mailgw1.iis.fraunhofer.de (Postfix) with ESMTPS id EDE642400082
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  9 Jun 2017 12:33:43 +0200 (CEST)
Received: from [10.12.71.18] (153.96.171.210) by mail03.iis.fhg.de
	(2001:638:a0a:1111:314f:f22c:4a37:b25a) with Microsoft SMTP Server
	(TLS) id 15.0.1263.5; Fri, 9 Jun 2017 12:33:43 +0200
To: <bitbake-devel@lists.openembedded.org>
From: Florian Doersch <florian.doersch@iis.fraunhofer.de>
Message-ID: <593A7987.1060001@iis.fraunhofer.de>
Date: Fri, 9 Jun 2017 12:33:43 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
	Thunderbird/38.3.0
MIME-Version: 1.0
X-Originating-IP: [153.96.171.210]
X-ClientProxiedBy: mail01.iis.fhg.de (2001:638:a0a:1111:fd91:8c2a:e4a5:e74e)
	To mail03.iis.fhg.de (2001:638:a0a:1111:314f:f22c:4a37:b25a)
X-cloud-security-sender: florian.doersch@iis.fraunhofer.de
X-cloud-security-recipient: bitbake-devel@lists.openembedded.org
X-cloud-security-crypt: load encryption module
X-cloud-security-Virusscan: CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on
	mx-relay12-hz1.antispameurope.com with 16B85820059
X-cloud-security-connect: mailgw1.iis.fraunhofer.de[153.96.172.4], TLS=1,
	IP=153.96.172.4
X-cloud-security: scantime:.1568
Subject: Bitbake and Git LFS
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
X-List-Received-Date: Fri, 09 Jun 2017 10:40:06 -0000
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I am currently using Bitbake via Yocto.

Since we use git lfs to store larger binary blobs in our git 
repositories, I ran into a problem building these repositories in bitbake.

I did some research and finally found a solution. I had to run "git lfs 
fetch --all" after "git clone --mirror", so an addition clone from the 
mirror has all necessary lfs objects available.

I've created a small patch (without any checks if git lfs is available 
or used, so theres still work to do)

--- poky/bitbake/lib/bb/fetch2/git.py.orig	2017-06-09 09:33:24.044338249 
+0200
+++ poky/bitbake/lib/bb/fetch2/git.py	2017-06-09 10:11:13.000000000 +0200
@@ -201,6 +201,7 @@
              if ud.proto.lower() != 'file':
                  bb.fetch2.check_network_access(d, clone_cmd)
              runfetchcmd(clone_cmd, d)
+            runfetchcmd("git -C %s lfs fetch --all" % ud.clonedir, d)

          os.chdir(ud.clonedir)
          # Update the checkout if needed

You can freely use it if helpful.

Is there already an "official solution for that kind of problem?

Best Regards
Florian


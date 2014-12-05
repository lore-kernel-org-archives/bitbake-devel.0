Return-Path: <joa_rodrigues@hotmail.com>
X-Greylist: delayed 303 seconds by postgrey-1.34 at layers.openembedded.org;
	Fri, 05 Dec 2014 10:25:19 UTC
Received: from BLU004-OMC4S4.hotmail.com (blu004-omc4s4.hotmail.com
	[65.55.111.143])
	by mail.openembedded.org (Postfix) with ESMTP id AF34D7232E
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  5 Dec 2014 10:25:18 +0000 (UTC)
Received: from BLU436-SMTP192 ([65.55.111.135]) by BLU004-OMC4S4.hotmail.com
	over TLS secured channel with Microsoft SMTPSVC(7.5.7601.22751);
	Fri, 5 Dec 2014 02:20:16 -0800
X-TMN: [2oFtzc820BKHGMsOEzkN7JZQZa8o1AGU]
X-Originating-Email: [joa_rodrigues@hotmail.com]
Message-ID: <BLU436-SMTP192AB6A39660DD6B433414D92790@phx.gbl>
Date: Fri, 5 Dec 2014 11:20:12 +0100
From: Joachim Rodrigues <joa_rodrigues@hotmail.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64;
	rv:31.0) Gecko/20100101 Thunderbird/31.3.0
MIME-Version: 1.0
To: bitbake-devel@lists.openembedded.org
References: <mailman.1288.1417467044.1406.bitbake-devel@lists.openembedded.org>
In-Reply-To: <mailman.1288.1417467044.1406.bitbake-devel@lists.openembedded.org>
X-OriginalArrivalTime: 05 Dec 2014 10:20:14.0268 (UTC)
	FILETIME=[0F00E7C0:01D01075]
Subject: import built image to vm
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
X-List-Received-Date: Fri, 05 Dec 2014 10:25:21 -0000
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit

Hi

I successfully created the Tizen image with Yocto
https://wiki.tizen.org/wiki/Build_Tizen_with_Yocto_Project


I haveTwo questions about that  :

First :
I'm running on Ubuntu 14.04 and by default /bin/sh is a link to the dash 
shell.
This is generates errors during the build process. So i changed the link 
to bash instead and it worked.

Is this the good way or is there a parameter in yocto that enables me 
the change the used shell ?



And finally when the build finished i have then my files : bzImage, my 
ext3 file etc
But canot find documentation on how to create a vmware or virtual box 
with that ???


Thanks



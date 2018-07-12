Return-Path: <clay@montgomery1.com>
X-Greylist: delayed 1993 seconds by postgrey-1.34 at layers.openembedded.org;
	Thu, 12 Jul 2018 16:41:10 UTC
Received: from gproxy8-pub.mail.unifiedlayer.com
	(gproxy8-pub.mail.unifiedlayer.com [67.222.33.93])
	by mail.openembedded.org (Postfix) with ESMTP id 9E14176060
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Jul 2018 16:41:10 +0000 (UTC)
Received: from cmgw13.unifiedlayer.com (unknown [10.9.0.13])
	by gproxy8.mail.unifiedlayer.com (Postfix) with ESMTP id 6BC331AB0D4
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Jul 2018 10:07:56 -0600 (MDT)
Received: from box858.bluehost.com ([69.195.124.58]) by cmsmtp with ESMTP
	id de8Kfz15TYe1jde8KfIQ7i; Thu, 12 Jul 2018 10:07:56 -0600
X-Authority-Reason: nr=8
Received: from cpe-97-99-239-0.tx.res.rr.com ([97.99.239.0]:50488
	helo=[192.168.0.21]) by box858.bluehost.com with esmtpsa
	(TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.91)
	(envelope-from <clay@montgomery1.com>) id 1fde8K-000OrE-36
	for bitbake-devel@lists.openembedded.org;
	Thu, 12 Jul 2018 10:07:56 -0600
To: bitbake-devel@lists.openembedded.org
From: "Clay D. Montgomery" <clay@montgomery1.com>
Organization: Montgomery One
Message-ID: <5B477CE2.2040602@montgomery1.com>
Date: Thu, 12 Jul 2018 11:08:02 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
	Thunderbird/38.0.1
MIME-Version: 1.0
X-AntiAbuse: This header was added to track abuse,
	please include it with any abuse report
X-AntiAbuse: Primary Hostname - box858.bluehost.com
X-AntiAbuse: Original Domain - lists.openembedded.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - montgomery1.com
X-BWhitelist: no
X-Source-IP: 97.99.239.0
X-Source-L: No
X-Exim-ID: 1fde8K-000OrE-36
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: cpe-97-99-239-0.tx.res.rr.com ([192.168.0.21])
	[97.99.239.0]:50488
X-Source-Auth: clay@montgomery1.com
X-Email-Count: 1
X-Source-Cap: bW9udGdvcjA7bW9udGdvcjA7Ym94ODU4LmJsdWVob3N0LmNvbQ==
X-Local-Domain: yes
Subject: Can't start menuconfig with Bitbake
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
X-List-Received-Date: Thu, 12 Jul 2018 16:41:10 -0000
X-Groupsio-MsgNum: 9385
Content-Type: multipart/mixed; boundary="------------090800080904010002070401"

--------------090800080904010002070401
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

    I am having a basic problem with trying to use Bitbake to run 
menuconfig.
Bitbake otherwise works fine for me. I have done many large builds of Yocto.

  I am running on a Ubuntu 14.04 32-bit system which is up to date, but 
the RAM is limited to 4 GB.
I have pasted a sample of the errors I get below.  I shortened this 
considerably.

I would appreciate any advice on how to resolve this.

Thanks, Clay Montgomery



bitbake -c menuconfig virtual/kernel


   GEN     ./Makefile
   HOSTLD  scripts/kconfig/mconf
scripts/kconfig/mconf.o: In function `show_help':
mconf.c:(.text+0x927): undefined reference to `stdscr'
scripts/kconfig/lxdialog/checklist.o: In function `print_arrows':
checklist.c:(.text+0x31): undefined reference to `wmove'
checklist.c:(.text+0x4e): undefined reference to `acs_map'
checklist.c:(.text+0x5a): undefined reference to `waddch'
util.c:(.text+0x1826): undefined reference to `keypad'
util.c:(.text+0x182e): undefined reference to `wgetch'
util.c:(.text+0x1838): undefined reference to `wgetch'
menubox.c:(.text+0x11db): undefined reference to `acs_map'
menubox.c:(.text+0x11eb): undefined reference to `waddch'
menubox.c:(.text+0x1278): undefined reference to `scrollok'
scripts/kconfig/lxdialog/menubox.o: In function `do_print_item':
menubox.c:(.text+0x1ab): undefined reference to `wrefresh'
scripts/kconfig/lxdialog/menubox.o: In function `print_buttons':
menubox.c:(.text+0x356): undefined reference to `wrefresh'
scripts/kconfig/lxdialog/menubox.o: In function `print_arrows.constprop.0':
menubox.c:(.text+0x478): undefined reference to `wrefresh'
collect2: error: ld returned 1 exit status
make[3]: *** [scripts/kconfig/mconf] Error 1
make[2]: *** [menuconfig] Error 2
make[1]: *** [sub-make] Error 2
make: *** [__sub-make] Error 2
Command failed.
Press any key to continue...


--------------090800080904010002070401
Content-Type: text/x-vcard; charset=utf-8;
 name="clay.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="clay.vcf"

begin:vcard
fn:Clay D. Montgomery
n:Montgomery;Clay
org:Montgomery One
adr:;;;;Texas;;USA
email;internet:clay@montgomery1.com
title:Freelance Software Developer
tel;cell:580-490-6676
x-mozilla-html:TRUE
url:http://montgomery1.com/contact/
version:2.1
end:vcard


--------------090800080904010002070401--

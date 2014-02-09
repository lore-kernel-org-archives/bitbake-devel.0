Return-Path: <rmcarlsson@gmail.com>
Received: from mail-lb0-f169.google.com (mail-lb0-f169.google.com
	[209.85.217.169])
	by mail.openembedded.org (Postfix) with ESMTP id C388F6E712
	for <bitbake-devel@lists.openembedded.org>;
	Sun,  9 Feb 2014 14:16:24 +0000 (UTC)
Received: by mail-lb0-f169.google.com with SMTP id q8so4031962lbi.14
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 09 Feb 2014 06:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=message-id:date:from:user-agent:mime-version:to:subject
	:content-type:content-transfer-encoding;
	bh=hWiv5CpefzOFdWcSwWBq39dpQ7lzxPinLEuAsxYVb60=;
	b=hclJ93VzEAyAaxazna6t9AEAEvg+dQ5biVMF6NPKheA9piL+slTO5oWlJekvsvIkO8
	FkackGbtZQV1nHG9S8lQgcBVw1kpbCID8O3gsTwqVByGfX3kRaIgEzAGB7guaqD9jG68
	VtSDZ9uE8dooUy9WZEQks3yTj4vxMH2Mf5D+vwW71x8t/6UsKKh8CuURnM1IeX3R43oA
	o/8Nt4yFZ4e/nMgt6BnZVLPKGpRqruCuxNkKVIpokUk3CjVGoQns000Wchwi0FKrcVRS
	okUAFLLylpNK+ftRMLkQwd1qlPmHlvWb3h+rLKnjXoFZ6BftuLUt4XdKt7+C5Qd7/D62
	Orlw==
X-Received: by 10.152.8.47 with SMTP id o15mr18107792laa.20.1391955384220;
	Sun, 09 Feb 2014 06:16:24 -0800 (PST)
Received: from [192.168.1.3] (c83-253-132-34.bredband.comhem.se.
	[83.253.132.34])
	by mx.google.com with ESMTPSA id y2sm17267075lal.10.2014.02.09.06.16.22
	for <bitbake-devel@lists.openembedded.org>
	(version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Sun, 09 Feb 2014 06:16:23 -0800 (PST)
Message-ID: <52F78DB6.7020903@gmail.com>
Date: Sun, 09 Feb 2014 15:16:22 +0100
From: Mikael Carlsson <rmcarlsson@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:24.0) Gecko/20100101 Thunderbird/24.2.0
MIME-Version: 1.0
To: bitbake-devel@lists.openembedded.org
Subject: Configure Yocto Eclipse plug-in with Build system derived toolchain
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
X-List-Received-Date: Sun, 09 Feb 2014 14:16:26 -0000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi!

I cannot make the Eclipse Yocto plug-in working properly with the Build 
system derived toolchain.

Some background; I have a Intel Galileo board. I have built the BSP, 
image-full. I have a fully operational ssh and serial connection. I have 
aslo built the toolschain. bitbake image-full -c populate_sdk. Using 
this toolchain I have built the most simplest program, uploaded it using 
scp and successfully executed it on target.

I don not however understand how to make the Yocto Eclipse plug-in work 
with the build system derived toolchain. I have built the toolchain with 
bitbake meta-ide-support. The first thing I would like to have help with 
is what paths to put in "Toolchain Root Location" and Sysroot Location".

Anyone got any ideas?

   / Mikael



Return-Path: <mauro@faresoftware.it>
X-Greylist: delayed 420 seconds by postgrey-1.34 at layers.openembedded.org;
	Mon, 12 Feb 2018 10:11:36 UTC
Received: from smtpcmd12131.aruba.it (smtpcmd12131.aruba.it [62.149.156.131])
	by mail.openembedded.org (Postfix) with ESMTP id 63B0B601F2
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 12 Feb 2018 10:11:36 +0000 (UTC)
Received: from [10.0.3.109] ([78.6.3.122])
	by smtpcmd12.ad.aruba.it with bizsmtp
	id 9m4b1x01a2dwwGE01m4cao; Mon, 12 Feb 2018 11:04:36 +0100
To: bitbake-devel@lists.openembedded.org
From: Mauro Ziliani <mauro@faresoftware.it>
Message-ID: <1aba030a-8f47-e51b-2af7-a2ee1fb54dc2@faresoftware.it>
Date: Mon, 12 Feb 2018 11:04:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.6.0
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aruba.it; s=a1;
	t=1518429876; bh=/aAVNGnsjVjOzEr8KTKz2HrbX9Rs9NlBweOZO5O23s4=;
	h=To:From:Subject:Date:MIME-Version:Content-Type;
	b=Y3PbUKZF3FMnPi435/M488jOCgEoZQwfZHKTI2uW/AoHSJA1qrLIXcVXvZChWwRt4
	DyCGKFjS/8iD0p0ayY2vU0alm262ThgzMLrowOgTAxYA0lrY2FbV9lCBgXVNC0pvSV
	TYmMX5F1dYx58BQOGWl4IULFVWQsflUMQENXJ+1b0pjD6qMJ795jgypygawu+Zz2I+
	kUSaBDCqaeK4trP1kAJoiR7Yg4xdj0zPnAtTm0KgzxF4PKaiKLYS8sq6TrNJ004nuZ
	Vy9OaDqtY6uUZss0K00iHPQwwCfZfobOvn7bnuQzHsB2BHZPByn2+QZKwVy1vH7zD0
	IYsAxpJ2RzqBA==
Subject: Bitbake show debug info always, regardless of -D param
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
X-List-Received-Date: Mon, 12 Feb 2018 10:11:37 -0000
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: it

Hi all.

My name's Mauro and I write from Parma, Italy.

I'm using Yocto Krogoth on a IMX6 DL SABRE SD board.

Suddenly, after a fsck command onto the development partition, bitbake 
show always debug informations.

I think sometthing went corrupt after fsck stage.

Where I can look to solve this tedious problem?

I tryed to reinstall the BSP into another folder, but bitbake keep on 
show all debug infos

Best regards,

   MZ


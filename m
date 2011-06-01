Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1QRmx2-00019D-Gc for bitbake-devel@lists.openembedded.org;
	Wed, 01 Jun 2011 17:03:16 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p51F03qr005509
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 1 Jun 2011 16:00:03 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 05247-05 for <bitbake-devel@lists.openembedded.org>;
	Wed,  1 Jun 2011 15:59:59 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p51Ext4Z005497
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 1 Jun 2011 15:59:56 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
In-Reply-To: <1306882804.27470.402.camel@rex>
References: <1306882804.27470.402.camel@rex>
Date: Wed, 01 Jun 2011 15:59:37 +0100
Message-ID: <1306940377.27470.429.camel@rex>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: Re: RFC: Override expansion - changing the behaviour
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
X-List-Received-Date: Wed, 01 Jun 2011 15:03:16 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

To follow up on this, what kind of cleanup would this and some other
tweaks to bitbake allow?

This is my proof of concept:

http://git.yoctoproject.org/cgit.cgi/poky-contrib/commit/?h=rpurdie/temp3&id=1ed909e8b9bac6ed88ffbbe6a100a42c4289f498

which cleans up native.bbclass and nativesdk.bbclass to be much cleaner
code with less strange side effects and hoops to jump through.

The main changes to bitbake after the original patch I posted were:

a) Add handlers before any data finalisation
b) Add a new "pre finalise" event

Cheers,

Richard




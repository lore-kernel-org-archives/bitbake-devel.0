Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1THXlg-0005YT-U8 for bitbake-devel@lists.openembedded.org;
	Fri, 28 Sep 2012 12:26:01 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q8SAD40t008889;
	Fri, 28 Sep 2012 11:13:04 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 08702-01; Fri, 28 Sep 2012 11:12:59 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q8SACsea008879
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 28 Sep 2012 11:12:56 +0100
Message-ID: <1348827176.15753.37.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: "Voicu, Cristiana" <cristiana.voicu@intel.com>
Date: Fri, 28 Sep 2012 11:12:56 +0100
In-Reply-To: <BE68E9C8E0850C43B0F0B0B7D57FA5AE19396846@IRSMSX101.ger.corp.intel.com>
References: <1348656248-5807-1-git-send-email-cristiana.voicu@intel.com>
	<1348760602.11186.4.camel@ted>
	<BE68E9C8E0850C43B0F0B0B7D57FA5AE19396846@IRSMSX101.ger.corp.intel.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH v2] hob/settings: implement a new tab in settings dialog to show SSTATE_MIRRORS
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
X-List-Received-Date: Fri, 28 Sep 2012 10:26:01 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2012-09-28 at 09:49 +0000, Voicu, Cristiana wrote:
> Hello,
> 
> I saw the changes in code were merged, but I have changed also 2
> images(bitbake/lib/bb/ui/icons/info/info_display.png &
> bitbake/lib/bb/ui/icons/info/info_hover.png). Those are not changed in
> master now.
> 
> Can you please check what happened?

Sorry, I've fixed this. Its a gremlin from doing this via email.

Cheers,

Richard




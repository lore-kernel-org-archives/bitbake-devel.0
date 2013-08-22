Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id E15EC60896
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 22 Aug 2013 11:38:17 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r7MBo158002902; Thu, 22 Aug 2013 12:50:01 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id Tmd9ieeDW3RT; Thu, 22 Aug 2013 12:50:01 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r7MBnwxO002796
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT); Thu, 22 Aug 2013 12:50:00 +0100
Message-ID: <1377171477.6762.0.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: "Voicu, Cristiana" <cristiana.voicu@intel.com>
Date: Thu, 22 Aug 2013 12:37:57 +0100
In-Reply-To: <BE68E9C8E0850C43B0F0B0B7D57FA5AE2E81DF92@IRSMSX105.ger.corp.intel.com>
References: <BE68E9C8E0850C43B0F0B0B7D57FA5AE2E81DF92@IRSMSX105.ger.corp.intel.com>
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: patch missed for #4321
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
X-List-Received-Date: Thu, 22 Aug 2013 11:38:18 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2013-08-22 at 10:24 +0000, Voicu, Cristiana wrote:
>  
> Andrei Dinu sent a patch for #4321. Here is the patch:
>
> http://patchwork.openembedded.org/patch/49917/
>
>  
> The bug is now assigned to me and I think  this patch was missed.

It was, sorry. I've merged the patch.

Cheers,

Richard




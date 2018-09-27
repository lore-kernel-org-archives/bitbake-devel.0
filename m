Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 9C47479862
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 27 Sep 2018 16:53:32 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-10) with ESMTPSA id
	w8RGrVBt007336
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NOT); Thu, 27 Sep 2018 17:53:32 +0100
Message-ID: <f3a9349906015f5961c688f27b82fa92967e5510.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: "Belal, Awais" <Awais_Belal@mentor.com>, "Reyna, David"
	<david.reyna@windriver.com>, "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Date: Thu, 27 Sep 2018 17:53:31 +0100
In-Reply-To: <1538034849901.46023@mentor.com>
References: <1536831336527.93802@mentor.com>
	, <5E53D14CE4667A45B9A06760DE5D13D0F3AC15D6@ALA-MBD.corp.ad.wrs.com>
	, <1537430385445.98207@mentor.com> <1538034849901.46023@mentor.com>
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
X-Virus-Scanned: clamav-milter 0.100.1 at dan
X-Virus-Status: Clean
Subject: Re: [sumo][PATCH] toaster: localhostbecontroller: fix bitbake path resolution
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
X-List-Received-Date: Thu, 27 Sep 2018 16:53:33 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2018-09-27 at 07:54 +0000, Belal, Awais wrote:
> >> I recommend this for both Sumo and for master as well, so that
> they stay in sync.
> Any thoughts here?

I'm confused. Does master need the patch? or only sumo?

Cheers,

Richard


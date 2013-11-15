Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 8EA6C6D1D5
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 Nov 2013 11:57:58 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	rAFBvlRL008897; Fri, 15 Nov 2013 11:57:47 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 5tAPUNp1Fmtz; Fri, 15 Nov 2013 11:57:47 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	rAFBvgJk008885
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT); Fri, 15 Nov 2013 11:57:43 GMT
Message-ID: <1384516659.6460.147.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: "Voicu, Cristiana" <cristiana.voicu@intel.com>
Date: Fri, 15 Nov 2013 11:57:39 +0000
In-Reply-To: <BE68E9C8E0850C43B0F0B0B7D57FA5AE2E8B0B60@IRSMSX105.ger.corp.intel.com>
References: <1384267824-19862-1-git-send-email-cristiana.voicu@intel.com>
	<BE68E9C8E0850C43B0F0B0B7D57FA5AE2E8B0B60@IRSMSX105.ger.corp.intel.com>
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] toaster: convert build_package size to bytes to keep consistence
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
X-List-Received-Date: Fri, 15 Nov 2013 11:57:59 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2013-11-15 at 11:47 +0000, Voicu, Cristiana wrote:
> This was merged to master, and it should be merged to dora-toaster branch too.
> Can you please merge it?

Alex is going to put together a branch with the patches he wants merged
there. I'll wait for that and then merge it that way.

Cheers,

Richard



Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 4FE776A456
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  6 Jun 2013 08:16:57 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r568LYv5015567; Thu, 6 Jun 2013 09:21:48 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id EziAnI5z5-_i; Thu,  6 Jun 2013 09:21:47 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r568Lif5015589
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT); Thu, 6 Jun 2013 09:21:46 +0100
Message-ID: <1370506598.1640.74.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: "Voicu, Cristiana" <cristiana.voicu@intel.com>
Date: Thu, 06 Jun 2013 09:16:38 +0100
In-Reply-To: <BE68E9C8E0850C43B0F0B0B7D57FA5AE2E7D6013@IRSMSX105.ger.corp.intel.com>
References: <1370440792.1640.48.camel@ted>
	<BE68E9C8E0850C43B0F0B0B7D57FA5AE2E7D6013@IRSMSX105.ger.corp.intel.com>
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [RFC PATCH] Split runqueue to use bitbake-worker
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 06 Jun 2013 08:16:57 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2013-06-06 at 08:00 +0000, Voicu, Cristiana wrote:
> I have tested your patches with Hob, but I can't see the issue for it.
> In Hob you can change the configuration at the begging (before
> starting the build task), so when the bitbake-worker will start will
> take the changed configuration. I have tested it changing the
> sstate-cache dir, and everything worked ok (it created a new dir for
> sstate-cache). Also, in Hob I can see the warnings you placed to see
> if the worker is working properly. 
> 
> Is there something I'm missing?

When I start hob I see a number of "setVariable" commands running. These
get set in the core configuration but they do not get set on the
bitbake-worker side.

I don't know which variables get set this way but they won't have any
effect after this patch.

Which variables get set this way? (Easiest way to find out would be to
add print statements to the code I guess).

We may need to change those writes to become actual editing of
local.conf to set values for example.

Cheers,

Richard



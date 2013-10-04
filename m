Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id EAFB560FA6
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  4 Oct 2013 13:37:32 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r94DbLtu008486; Fri, 4 Oct 2013 14:37:21 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id NyFK_QRp9Rus; Fri,  4 Oct 2013 14:37:21 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r94DbIYh008483
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT); Fri, 4 Oct 2013 14:37:20 +0100
Message-ID: <1380893834.18603.608.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: "cristiana.voicu" <cristiana.voicu@intel.com>
Date: Fri, 04 Oct 2013 14:37:14 +0100
In-Reply-To: <524D70DD.7050709@intel.com>
References: <1380291041-11238-1-git-send-email-valentin.popa@intel.com>
	<52492975.20408@intel.com> <524D70DD.7050709@intel.com>
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] HOB: MACHINE should be saved in conf files using ?=
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
X-List-Received-Date: Fri, 04 Oct 2013 13:37:33 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2013-10-03 at 16:27 +0300, cristiana.voicu wrote:
> I know I replied with an ack for this patch, but working on a similar 
> bug I realized that replacing the comment "total += "\n#added by 
> bitbake" with total += "\n#added by hob" in bitbake code is not ok. I 
> think it will be better to give as argument the comment string, in order 
> to keep this method reusable in  other ui.

To make things simpler can someone send a follow up patch to make this a
parameter please?

Cheers,

Richard



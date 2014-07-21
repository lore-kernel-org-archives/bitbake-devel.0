Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id ACFAF65CC1
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 21 Jul 2014 18:24:31 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s6LIOPIG022340; Mon, 21 Jul 2014 19:24:26 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id YgS886Q09v1B; Mon, 21 Jul 2014 19:24:25 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s6LIOHJF022334
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 21 Jul 2014 19:24:19 +0100
Message-ID: <1405967052.22985.105.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Dennis Meier <meier.dennis@siemens.com>
Date: Mon, 21 Jul 2014 19:24:12 +0100
In-Reply-To: <1405589025-26527-1-git-send-email-meier.dennis@siemens.com>
References: <1405589025-26527-1-git-send-email-meier.dennis@siemens.com>
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Cc: henrique.mendonca@siemens.com, pascal.bach@siemens.com,
	christian.liechti@siemens.com,
	bitbake-devel@lists.openembedded.org, r.meier@siemens.com
Subject: Re: [PATCH] fetch2: Add module for ClearCase (ccrc://)
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
X-List-Received-Date: Mon, 21 Jul 2014 18:24:33 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2014-07-17 at 11:23 +0200, Dennis Meier wrote:
> I sumbitted this patch as a pull request on github this morning
> (https://github.com/openembedded/bitbake/pull/6). After consulting
> Richard Purdie on IRC I'm resubmitting here. I hope to comply with all
> the formalities :). We are looking forward to hearing from you.

I'm going to merge this as is. I don't have clearcase and I don't really
want to know either. I'll therefore be relying on users of it to keep to
keep it working.

Cheers,

Richard



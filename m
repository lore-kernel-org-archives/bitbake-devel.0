Return-Path: <Joe.MacDonald@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 309066AE36
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Jun 2013 15:05:13 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id r5SF5BQn023614
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Fri, 28 Jun 2013 08:05:11 -0700 (PDT)
Received: from burninator.wrs.com (128.224.146.166) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.40) with Microsoft SMTP Server id 14.2.342.3;
	Fri, 28 Jun 2013 08:05:11 -0700
From: Joe MacDonald <joe.macdonald@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 28 Jun 2013 11:05:05 -0400
Message-ID: <1372431907-10142-1-git-send-email-joe.macdonald@windriver.com>
X-Mailer: git-send-email 1.7.10.4
MIME-Version: 1.0
Subject: [RFC PATCH] Allow remote sstate cache fetches when BB_NO_NETWORK set
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
X-List-Received-Date: Fri, 28 Jun 2013 15:05:13 -0000
Content-Type: text/plain

My objective here is to support a very specific scenario.  I have a well-fed
sstate cache on my internal network.  I want to use it for accelerating builds
across a variety of machines where NFS is not really an option.  I don't want
bitbake to ever attempt to fetch sources for packages, though, so I'm always
using BB_NO_NETWORK.

The proposal I have is adding a new local.conf variable that will allow cache
fetches only to be exempt from BB_NO_NETWORK restrictions.  If it is set and
BB_NO_NETWORK is not set, there's no change in behaviour.  If it is not set and
BB_NO_NETWORK is set, again, no change in today's behaviour.  If both are set,
however, then any of the regular fetch2 fetchers will get an "okay" from
check_network_access() if they're invoked by a sstate cache fetch attempt.  Any
other fetch attempt will still hit raise a NetworkAccess exception.

-- 
-Joe MacDonald.
:wq



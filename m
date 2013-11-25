Return-Path: <jason.wessel@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id D47DC6D2F8
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 25 Nov 2013 21:21:32 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail1.windriver.com (8.14.5/8.14.5) with ESMTP id rAPLLV3Z013089
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 25 Nov 2013 13:21:31 -0800 (PST)
Received: from ord-jrw.corp.ad.wrs.com (172.25.32.36) by
	ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server id
	14.2.347.0; Mon, 25 Nov 2013 13:21:31 -0800
From: Jason Wessel <jason.wessel@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 25 Nov 2013 15:21:24 -0600
Message-ID: <1385414489-2901-1-git-send-email-jason.wessel@windriver.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Subject: [RFC PATCH 0/5] bitbake memory resident improvements
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
X-List-Received-Date: Mon, 25 Nov 2013 21:21:35 -0000
Content-Type: text/plain

The idea with this patch set is to improve the way bitbake is started
up with the memory resident server.  The following were the goals of
this patch set.

1) Allow switching between the memres and non memres mode by sourcing
   the environment scripts.  Example:
   bash
   . oe-init-build-env-memres
   exit
   bash
   . oe-init-build-env
   exit

2) Do not hard code a port number for the default memres setup.
   Instead allow the port number to be setup dynamically so that
   multiple memres servers can be started in multiple directories by
   multiple users on the same system.

3) Start the bitbake memory resident server as needed.
   * This allows lazy start up
   * Restarts the server if it should exit after an inactivity timeout
     NOTE: This patch set does not implement the inactivity timeout
           but it does implement the recovery.
   * If the server dies it is started automatically


Cheers,
Jason


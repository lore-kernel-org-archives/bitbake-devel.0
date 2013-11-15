Return-Path: <Konrad.Scherer@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id D70776D476
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 Nov 2013 20:51:46 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.5) with ESMTP id rAFKplGv015743
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 Nov 2013 12:51:47 -0800 (PST)
Received: from yow-kscherer-d1.wrs.com (128.224.146.215) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.2.347.0; Fri, 15 Nov 2013 12:51:48 -0800
From: Konrad Scherer <konrad.scherer@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 15 Nov 2013 15:51:46 -0500
Message-ID: <1384548707-31336-1-git-send-email-konrad.scherer@windriver.com>
X-Mailer: git-send-email 1.8.3.2
MIME-Version: 1.0
Subject: [Patch 0/1] serv.py: Give pr-server up to 5 seconds to commit data
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
X-List-Received-Date: Fri, 15 Nov 2013 20:51:47 -0000
Content-Type: text/plain

Half a second for sqlite to commit pr data to disk is not enough. By
polling the pid, the pr-server has a chance to shutdown cleanly.

---
Konrad Scherer, MTS, Linux Products Group, Wind River


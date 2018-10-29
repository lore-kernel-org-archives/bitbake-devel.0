Return-Path: <tomasz.meresinski@comarch.pl>
X-Greylist: delayed 2026 seconds by postgrey-1.34 at layers.openembedded.org;
	Mon, 29 Oct 2018 17:13:35 UTC
Received: from odzwierny1.comarch.com (odzwierny1.comarch.com [217.74.69.9])
	by mail.openembedded.org (Postfix) with ESMTP id 9474C79A9C
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 29 Oct 2018 17:13:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	authenticated as tomasz.meresinski@comarch.com
	by odzwierny1.comarch.com with esmtpsa (TLSv1:AES256-SHA:256)(ComArch
	ESMTP) id 1gHAZx-000BL7-BB for bitbake-devel@lists.openembedded.org;
	Mon, 29 Oct 2018 17:39:49 +0100
From: =?UTF-8?q?Tomasz=20Meresi=C5=84ski?= <tomasz.meresinski@comarch.pl>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 29 Oct 2018 17:39:30 +0100
Message-Id: <20181029163933.26646-1-tomasz.meresinski@comarch.pl>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-CA-Antivirus: Scanned by ComArch Antivirus on odzwierny1.comarch.com
X-CA-Is-Spam: No
Subject: ui/json: Add JSON UI to Bitbake
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
X-List-Received-Date: Mon, 29 Oct 2018 17:13:35 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Create JSON UI so other tools can integrate easier with Bitbake build
system.

It exposes all public fields and properties of events as JSON
output.




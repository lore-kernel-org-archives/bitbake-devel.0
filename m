Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id C2BF960746
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 19 Jul 2016 07:58:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u6J7wiQ0028067; Tue, 19 Jul 2016 08:58:44 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id Hlj0fivcfAAA; Tue, 19 Jul 2016 08:58:44 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u6J7wdef028064
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 19 Jul 2016 08:58:40 +0100
Message-ID: <1468915119.14148.12.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Elliot Smith <elliot.smith@intel.com>, bitbake-devel@lists.openembedded.org
Date: Tue, 19 Jul 2016 08:58:39 +0100
In-Reply-To: <1468578727-30368-1-git-send-email-elliot.smith@intel.com>
References: <1468578727-30368-1-git-send-email-elliot.smith@intel.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: Re: [PATCH] toaster-tests: add class SeleniumTestCaseBase for browser tests
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
X-List-Received-Date: Tue, 19 Jul 2016 07:58:49 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Fri, 2016-07-15 at 11:32 +0100, Elliot Smith wrote:
> From: Aníbal Limón <anibal.limon@linux.intel.com>
> 
> In order to reuse the Selenium helper outside a Django
> environment (for functional testing), add a new module
> containing the base class SeleniumTestCaseBase, which only
> inherits unittest.TestCase
> 
> Add a class SeleniumTestCase with multiple inheritance of
> StaticLiveServerTestCase and SeleniumTestCaseBase to prevent
> existing tests from breaking.
> 
> Signed-off-by: Aníbal Limón <anibal.limon@linux.intel.com>
> Signed-off-by: Elliot Smith <elliot.smith@intel.com>

Could someone rebase this against master please? I merged Brian/Ed's
larger series and I think this has conflicts with it.

Cheers,

Richard


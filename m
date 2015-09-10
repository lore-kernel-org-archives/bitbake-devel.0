Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id E40A060053
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 10 Sep 2015 08:57:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t8A8vlWe004278; Thu, 10 Sep 2015 09:57:47 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id lBkqu2_Gxydh; Thu, 10 Sep 2015 09:57:47 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t8A8vXxC004273
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 10 Sep 2015 09:57:45 +0100
Message-ID: <1441875453.24871.319.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Brian Avery <avery.brian@gmail.com>
Date: Thu, 10 Sep 2015 09:57:33 +0100
In-Reply-To: <CAKV_0ehTok59e7oEv4E8a8BcLf7nwCwTTAmmcAX2G=peDjLAkw@mail.gmail.com>
References: <cover.1440096890.git.avery.brian@gmail.com>
	<413321e2452f75e96cff05f46505b5789824ddaa.1440096890.git.avery.brian@gmail.com>
	<55EEB8D6.6010404@intel.com>
	<CAKV_0ej3m1YrKf1Jypn3sJ96O2SsdsOBBZMNiLb_b75KPgwQqA@mail.gmail.com>
	<CAKV_0ehTok59e7oEv4E8a8BcLf7nwCwTTAmmcAX2G=peDjLAkw@mail.gmail.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/1] toastergui: Add frontend javascript unit tests
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
X-List-Received-Date: Thu, 10 Sep 2015 08:57:53 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2015-09-09 at 15:04 -0700, Brian Avery wrote:
> should I resubmit this to get the js and html file merged?
> -b
> 
> On Tue, Sep 8, 2015 at 2:09 PM, Brian Avery <avery.brian@gmail.com> wrote:
> > yes, the following files were new in the patch and were not created:
> > lib/toaster/toastergui/static/js/tests/test.js
> > b/lib/toaster/toastergui/static/js/tests/test.js
> > lib/toaster/toastergui/templates/js-unit-tests.html
> > b/lib/toaster/toastergui/templates/js-unit-tests.html
> >

I believe this was fixed yesterday. Let me know if not.

Cheers,

Richard



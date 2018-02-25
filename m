Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id DCFB2601F1
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 25 Feb 2018 22:11:58 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	w1PMBvpI024379
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Sun, 25 Feb 2018 22:11:58 GMT
Message-ID: <1519596717.24236.384.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Paul Barker <pbarker@toganlabs.com>
Date: Sun, 25 Feb 2018 22:11:57 +0000
In-Reply-To: <CAPyrkgwKMnb7OchXGr8OE3f_NK90ehxphS1HzGpOYjuyaKemhQ@mail.gmail.com>
References: <1517314210-25684-1-git-send-email-richard.purdie@linuxfoundation.org>
	<1517314210-25684-4-git-send-email-richard.purdie@linuxfoundation.org>
	<CAPyrkgwKMnb7OchXGr8OE3f_NK90ehxphS1HzGpOYjuyaKemhQ@mail.gmail.com>
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
X-Virus-Scanned: clamav-milter 0.99.3 at dan
X-Virus-Status: Clean
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 4/4] runqueue: Rewrite and optimize recrdepends handling
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
X-List-Received-Date: Sun, 25 Feb 2018 22:11:59 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Sun, 2018-02-25 at 19:25 +0000, Paul Barker wrote:
> I've been having build failures recently which I've tracked down to
> this commit in bitbake via git bisect.
> 
> I have an image recipe, oryx-image, and a publish recipe,
> oryx-publish. In oryx-publish I have a do_publish task that copies
> files out of "tmp/deploy/images/*" to their final places and so it
> needs to run after the tasks in oryx-image that create the relevant
> files. So I've explicitly added oryx-image:do_build to
> do_publish[depends].

Is do_publish added before do_build?
Does oryx-publish inherit any of the image/meta classes?

I suspect I need to better understand the problem as you've described
what you think the problem is but not what problem you're seeing...

Cheers,

Richard



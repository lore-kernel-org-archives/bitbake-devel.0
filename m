Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id C822F78124
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 25 May 2017 16:32:58 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	v4PGWskp030127
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Thu, 25 May 2017 17:32:57 +0100
Message-ID: <1495729973.25229.33.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Christopher Larson <kergoth@gmail.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Date: Thu, 25 May 2017 17:32:53 +0100
In-Reply-To: <CABcZANnuX6SLn21vO8xUz65U1oyzJ2_kgGEW6cE359R-NY+M9Q@mail.gmail.com>
References: <cover.1494623828.git.chris_larson@mentor.com>
	<CABcZANnuX6SLn21vO8xUz65U1oyzJ2_kgGEW6cE359R-NY+M9Q@mail.gmail.com>
X-Mailer: Evolution 3.18.5.2-0ubuntu3.1 
Mime-Version: 1.0
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.11
	(dan.rpsys.net [192.168.3.1]);
	Thu, 25 May 2017 17:32:58 +0100 (BST)
X-Virus-Scanned: clamav-milter 0.99.2 at dan
X-Virus-Status: Clean
Subject: Re: [PATCH 0/8] Add support for shallow mirror tarballs
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
X-List-Received-Date: Thu, 25 May 2017 16:33:02 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2017-05-25 at 08:42 -0700, Christopher Larson wrote:
> 
> On Fri, May 12, 2017 at 2:46 PM, Christopher Larson <kergoth@gmail.co
> m> wrote:
> > The latest incarnation of the support for git shallow mirror
> > tarballs. Updated
> > with ud.mirrortarball removed, fixes for gitsm and gitannex, more
> > granular
> > commits to ease review, and unit tests added. Please let me know
> > what you
> > think. Thanks.
> > 
> Any feedback on this, or are folks still fighting fires related to
> the release?

I'm travelling, lets aim to discuss this with a view to merging next
week [remind me if I forget please].

Cheers,

Richard


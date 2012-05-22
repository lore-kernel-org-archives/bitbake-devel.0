Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Peter.Seebach@windriver.com>) id 1SWrt0-0003Bx-5d
	for bitbake-devel@lists.openembedded.org;
	Tue, 22 May 2012 18:24:38 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail1.windriver.com (8.14.3/8.14.3) with ESMTP id q4MGEQeV014846
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Tue, 22 May 2012 09:14:26 -0700 (PDT)
Received: from wrlaptop (172.25.40.226) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.1.255.0;
	Tue, 22 May 2012 09:14:25 -0700
Date: Tue, 22 May 2012 11:13:59 -0500
From: Peter Seebach <peter.seebach@windriver.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Message-ID: <20120522111359.54be2700@wrlaptop>
In-Reply-To: <1337694219.8248.6.camel@ted>
References: <cover.1337612802.git.peter.seebach@windriver.com>
	<CABcZANkcJQsc2Up1umRX1ek3m+waB-Pq3cFYOCQb3A+4Uh0RNw@mail.gmail.com>
	<1337694219.8248.6.camel@ted>
X-Mailer: Claws Mail 3.7.8 (GTK+ 2.24.4; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: Chris Larson <clarson@kergoth.com>, bitbake-devel@lists.openembedded.org
Subject: Re: v2 [PATCH 0/2] data_smart.py: Track inclusions and assignments
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 22 May 2012 16:24:38 -0000
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit

On Tue, 22 May 2012 14:43:39 +0100
Richard Purdie <richard.purdie@linuxfoundation.org> wrote:

> So I want to take a closer look through the patches but I'm leaning
> toward merging them. If we find ways to make things neater, great but
> this is probably as good a start as we can hope for.

They need one small bug fixed (there's a missing [1] in the mods to
createCopy), but apart from that I'm using them without noticeable
trouble.

If these get added to bitbake, there's a related change to oe-core
that might be handy, to suppress sanity checks when using this feature
so you can get an explanation of what went wrong.

-s
-- 
Listen, get this.  Nobody with a good compiler needs to be justified.



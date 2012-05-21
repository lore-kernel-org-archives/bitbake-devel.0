Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Peter.Seebach@windriver.com>) id 1SWZLQ-0002IO-AQ
	for bitbake-devel@lists.openembedded.org;
	Mon, 21 May 2012 22:36:44 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id q4LKQWKp002150
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Mon, 21 May 2012 13:26:32 -0700 (PDT)
Received: from wrlaptop (172.25.40.226) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.1.255.0;
	Mon, 21 May 2012 13:26:32 -0700
Date: Mon, 21 May 2012 15:26:16 -0500
From: Peter Seebach <peter.seebach@windriver.com>
To: Chris Larson <clarson@kergoth.com>
Message-ID: <20120521152616.0777711a@wrlaptop>
In-Reply-To: <CABcZANkcJQsc2Up1umRX1ek3m+waB-Pq3cFYOCQb3A+4Uh0RNw@mail.gmail.com>
References: <cover.1337612802.git.peter.seebach@windriver.com>
	<CABcZANkcJQsc2Up1umRX1ek3m+waB-Pq3cFYOCQb3A+4Uh0RNw@mail.gmail.com>
X-Mailer: Claws Mail 3.7.8 (GTK+ 2.24.4; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
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
X-List-Received-Date: Mon, 21 May 2012 20:36:44 -0000
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit

On Mon, 21 May 2012 12:54:10 -0700
Chris Larson <clarson@kergoth.com> wrote:

> While these still aren't the prettiest, I think they're a lot cleaner
> than they were, and given the obvious value, I think we should
> consider merging them.

The only other thing that sort of occurred to me was that it might be
useful in such a case to break out the parts of finalize so the
tracking of assignments and changes which occur there to be more
obvious.  (Say, move the _append and _override logics to their own
functions.)

Not sure it's worth it, though.  I suppose I could just make those
setVars be (var, value, None, None, 'append') or whatever.

-s
-- 
Listen, get this.  Nobody with a good compiler needs to be justified.



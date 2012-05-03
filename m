Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Peter.Seebach@windriver.com>) id 1SQ1eu-0000NC-TB
	for bitbake-devel@lists.openembedded.org;
	Thu, 03 May 2012 21:25:49 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail1.windriver.com (8.14.3/8.14.3) with ESMTP id q43JG283026550
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 3 May 2012 12:16:02 -0700 (PDT)
Received: from wrlaptop (172.25.40.226) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.1.255.0;
	Thu, 3 May 2012 12:16:02 -0700
Date: Thu, 3 May 2012 14:15:35 -0500
From: Peter Seebach <peter.seebach@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Message-ID: <20120503141535.4aae4df9@wrlaptop>
In-Reply-To: <20120503132127.1cc1b29a@wrlaptop>
References: <20120503132127.1cc1b29a@wrlaptop>
X-Mailer: Claws Mail 3.7.8 (GTK+ 2.24.4; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Subject: Re: Bitbake patches: Track include history and variable modification history
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
X-List-Received-Date: Thu, 03 May 2012 19:25:49 -0000
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit

On Thu, 3 May 2012 13:21:27 -0500
Peter Seebach <peter.seebach@windriver.com> wrote:

> Note that the include tracking is noticably incomplete; most
> obviously, in this example, it never finds layer.conf.  Haven't
> quite figured out why, still looking at it, but the basic
> principle should stay the same.

Mystery solved, for reference:  The tracking needs to happen
in bb.parse.handle, and that turns out to require making the
createCopy in the := assignment case suppress the history copy,
or maybe just making the history copy bug-tolerant.

-s
-- 
Listen, get this.  Nobody with a good compiler needs to be justified.



Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Peter.Seebach@windriver.com>) id 1T20NK-0008JS-QH
	for bitbake-devel@lists.openembedded.org;
	Thu, 16 Aug 2012 15:44:39 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id q7GDWcqh012712
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Thu, 16 Aug 2012 06:32:38 -0700 (PDT)
Received: from e6410-2 (172.25.40.226) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.2.309.2;
	Thu, 16 Aug 2012 06:32:38 -0700
Date: Thu, 16 Aug 2012 08:32:31 -0500
From: Peter Seebach <peter.seebach@windriver.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Message-ID: <20120816083231.4d7cb4b0@e6410-2>
In-Reply-To: <1345112026.14667.40.camel@ted>
References: <cover.1345079338.git.peter.seebach@windriver.com>
	<2e26350de4ff2c38348031f65acac2f29d8656b9.1345079338.git.peter.seebach@windriver.com>
	<1345112026.14667.40.camel@ted>
X-Mailer: Claws Mail 3.8.0 (GTK+ 2.24.10; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 2/2] data_smart.py: implement _remove as a keyword like _append.
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
X-List-Received-Date: Thu, 16 Aug 2012 13:44:39 -0000
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit

On Thu, 16 Aug 2012 11:13:46 +0100
Richard Purdie <richard.purdie@linuxfoundation.org> wrote:

> I read this far.
> 
> This is not going to make any friends. += and =+ behave differently to
> _append with immediate vs. delayed functionality. I think equating -=
> and =- is just going to confuse users even more. So no, I don't think
> we can do this.

I'm fine with dropping that part, I just put it in because it was a
pretty close analogue to +=/=+. It would not be hard to remove that.

> Why does this depend on 1/2 ?

Because I didn't think I could write it without the tracking code to
see what was happening.

-s
-- 
Listen, get this.  Nobody with a good compiler needs to be justified.



Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Peter.Seebach@windriver.com>) id 1UFqgV-0004fP-Dp
	for bitbake-devel@lists.openembedded.org;
	Wed, 13 Mar 2013 19:46:10 +0100
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.3) with ESMTP id r2DITAPM004698
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Wed, 13 Mar 2013 11:29:10 -0700 (PDT)
Received: from e6410-2 (172.25.40.227) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.40) with Microsoft SMTP Server id 14.2.342.3;
	Wed, 13 Mar 2013 11:29:10 -0700
Date: Wed, 13 Mar 2013 13:28:57 -0500
From: Peter Seebach <peter.seebach@windriver.com>
To: Paul Eggleton <paul.eggleton@linux.intel.com>
Message-ID: <20130313132857.505e0f96@e6410-2>
In-Reply-To: <2406047.qZssv5BGAg@helios>
References: <1362833241.9443.208.camel@ted>
	<CABcZANmT5Z6B=PoD9k06aqFq08nzDjUt9DYkBUwdgSTFLKM+6w@mail.gmail.com>
	<2406047.qZssv5BGAg@helios>
X-Mailer: Claws Mail 3.8.0 (GTK+ 2.24.10; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: Chris Larson <clarson@kergoth.com>, bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] data_smart: Add _remove operator
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
X-List-Received-Date: Wed, 13 Mar 2013 18:46:10 -0000
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit

On Sun, 10 Mar 2013 20:39:07 +0000
Paul Eggleton <paul.eggleton@linux.intel.com> wrote:

> I can't recall if we've discussed this before, but shouldn't we be looking at 
> introducing some understanding of list type variables into BitBake itself? If 
> BitBake knew the variable was a list it would be possible to have language 
> elements that understood how to behave in this situation.

I rather like this. I would like to have _remove, and it may even make sense
to adopt _remove in the short term, but really I think most of the things
where we're using append/remove should probably be lists, which would also
eliminate the entire category of bugs in which it is unclear whether or not
to add a space.

Rough thoughts about implementation: Listness could be a flag.

LIST[list] = " "
LIST = "blah blah blah"
# Oh, hey, what if...
PATH[list] = ":"

or as shorthand:

LIST = [blah blah blah]

If this is done, the behavior of append/prepend is slightly altered (to
always ensure separators are added when needed), and then we could more
easily handle the remove case, too.

That said: I'd rather see a plain _remove go in than wait on a larger and
fancier design.

-s
-- 
Listen, get this.  Nobody with a good compiler needs to be justified.



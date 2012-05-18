Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Peter.Seebach@windriver.com>) id 1SVRHs-0004Er-Ii
	for bitbake-devel@lists.openembedded.org;
	Fri, 18 May 2012 19:48:24 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id q4IHcJ2k026942
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 18 May 2012 10:38:20 -0700 (PDT)
Received: from wrlaptop (172.25.40.226) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.1.255.0;
	Fri, 18 May 2012 10:38:19 -0700
Date: Fri, 18 May 2012 12:38:07 -0500
From: Peter Seebach <peter.seebach@windriver.com>
To: Peter Seebach <peter.seebach@windriver.com>
Message-ID: <20120518123807.27ff41d9@wrlaptop>
In-Reply-To: <c46dd7e0f30c447a10df5a50c92217150e434996.1337361285.git.peter.seebach@windriver.com>
References: <cover.1337361285.git.peter.seebach@windriver.com>
	<c46dd7e0f30c447a10df5a50c92217150e434996.1337361285.git.peter.seebach@windriver.com>
X-Mailer: Claws Mail 3.7.8 (GTK+ 2.24.4; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [RFC PATCH 1/2] data_smart.py: Provide (optional) logging of variable modifications
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
X-List-Received-Date: Fri, 18 May 2012 17:48:25 -0000
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit

On Fri, 18 May 2012 12:27:39 -0500
Peter Seebach <peter.seebach@windriver.com> wrote:

> -        data.setVar('BBINCLUDED',bb.parse.get_file_depends(data))
> +        data.setVar('BBINCLUDED',bb.parse.get_file_depends(data),
> 'cooker.py', 'N/A')

kergoth points out, quite cleverly, that most of the changes that look
like this could be removed.  His suggestion:  Instead of defaulting to
"unknown" for the optional arguments, default to "use the Python stack
inspection to identify the caller."

This seems like a really good idea to me, because it allows us to get
meaningful data in nearly all the cases, while preserving the option of
specifying other values when, say, parsing config files.

Any objections to that as a plan for a v2?

-s
-- 
Listen, get this.  Nobody with a good compiler needs to be justified.



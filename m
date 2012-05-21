Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Peter.Seebach@windriver.com>) id 1SWTX4-0004uH-QS
	for bitbake-devel@lists.openembedded.org;
	Mon, 21 May 2012 16:24:23 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id q4LEEBJT004921
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Mon, 21 May 2012 07:14:11 -0700 (PDT)
Received: from wrlaptop (172.25.40.226) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.1.255.0;
	Mon, 21 May 2012 07:14:10 -0700
Date: Mon, 21 May 2012 09:13:55 -0500
From: Peter Seebach <peter.seebach@windriver.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Message-ID: <20120521091355.7f1a2ea3@wrlaptop>
In-Reply-To: <1337609243.22747.4.camel@ted>
References: <1337527267-2196-1-git-send-email-enrico.scholz@sigma-chemnitz.de>
	<1337609243.22747.4.camel@ted>
X-Mailer: Claws Mail 3.7.8 (GTK+ 2.24.4; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>,
	bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] bitbake: added -j option
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
X-List-Received-Date: Mon, 21 May 2012 14:24:23 -0000
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit

On Mon, 21 May 2012 15:07:23 +0100
Richard Purdie <richard.purdie@linuxfoundation.org> wrote:

> I think in this case you may as well just whitelist BB_NUMBER_THREADS
> from the environment and set that variable there. I'm not seeing a
> huge need for the specific commandline option...

Principle of least astonishment?  I expect things that can run stuff in
parallel to specify that with -j.  Not strongly enough to have submitted
such a patch, but I can see the appeal.

-s
-- 
Listen, get this.  Nobody with a good compiler needs to be justified.



Received: from mail.cvg.de ([62.153.82.30])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <enrico.scholz@sigma-chemnitz.de>)
	id 1Sk2kW-0004vj-2A; Thu, 28 Jun 2012 02:38:20 +0200
Received: from ensc-virt.intern.sigma-chemnitz.de
	(ensc-virt.intern.sigma-chemnitz.de [192.168.3.24])
	by mail.cvg.de (8.14.4/8.14.4) with ESMTP id q5S0RLLL023684
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 28 Jun 2012 02:27:22 +0200
Received: from ensc by ensc-virt.intern.sigma-chemnitz.de with local (Exim
	4.76) (envelope-from <ensc@sigma-chemnitz.de>)
	id 1Sk2aA-0008Ap-Rt; Thu, 28 Jun 2012 02:27:38 +0200
From: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
References: <1340793253.23146.19.camel@ted>
	<1340808774-24884-1-git-send-email-enrico.scholz@sigma-chemnitz.de>
	<1340829332.23146.86.camel@ted>
	<lyr4t0e1bx.fsf@ensc-virt.intern.sigma-chemnitz.de>
Date: Thu, 28 Jun 2012 02:27:38 +0200
In-Reply-To: <lyr4t0e1bx.fsf@ensc-virt.intern.sigma-chemnitz.de> (Enrico
	Scholz's message of "Thu, 28 Jun 2012 02:18:10 +0200")
Message-ID: <lymx3oe0w5.fsf@ensc-virt.intern.sigma-chemnitz.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.97 (gnu/linux)
MIME-Version: 1.0
Sender: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
X-DSPAM-Result: Innocent
X-DSPAM-Probability: 0
X-DSPAM-Confidence: 0.99
X-Spam-Score: -5.3
X-Spam-Level: -----
X-Spam-Tests: AWL,BAYES_00,SPF_NEUTRAL,T_RP_MATCHES_RCVD,DSPAM_INNOCENT
X-Scanned-By: MIMEDefang 2.73
Cc: bitbake-devel@lists.openembedded.org,
	openembedded-core@lists.openembedded.org
Subject: Re: [PATCH 20/20] fetch: allow regexps in mirror protocol
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
X-List-Received-Date: Thu, 28 Jun 2012 00:38:20 -0000
Content-Type: text/plain

Enrico Scholz <enrico.scholz@sigma-chemnitz.de> writes:

>>> -            if i != uri_decoded[loc]:
>>> +            if not re.match(i, uri_decoded[loc]):
>
> | FAIL: test_urilist2 (bb.tests.fetch.FetcherTest)
> | AssertionError: Lists differ: ['file:///somepath/downloads/b... != ['file:///someotherpath/downlo...
> | - ['file:///somepath/downloads/bitbake-1.0.tar.gz',
> | -  'file:///someotherpath/downloads/bitbake-1.0.tar.gz']
> | ? ^
> | 
> | + ['file:///someotherpath/downloads/bitbake-1.0.tar.gz']
> | ? ^
>
> Nothing which seems to be related to the patch.

I have to correct me... the new line should be

| +            if not re.match(i + '$', uri_decoded[loc]):

to match the complete protocol.



Enrico



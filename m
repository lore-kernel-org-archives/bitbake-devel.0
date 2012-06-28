Received: from mail.cvg.de ([62.153.82.30])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <enrico.scholz@sigma-chemnitz.de>)
	id 1Sk2bX-0004jU-8k; Thu, 28 Jun 2012 02:29:03 +0200
Received: from ensc-virt.intern.sigma-chemnitz.de
	(ensc-virt.intern.sigma-chemnitz.de [192.168.3.24])
	by mail.cvg.de (8.14.4/8.14.4) with ESMTP id q5S0Hr2Q022819
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 28 Jun 2012 02:17:54 +0200
Received: from ensc by ensc-virt.intern.sigma-chemnitz.de with local (Exim
	4.76) (envelope-from <ensc@sigma-chemnitz.de>)
	id 1Sk2R0-0007wF-Qz; Thu, 28 Jun 2012 02:18:10 +0200
From: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
References: <1340793253.23146.19.camel@ted>
	<1340808774-24884-1-git-send-email-enrico.scholz@sigma-chemnitz.de>
	<1340829332.23146.86.camel@ted>
Date: Thu, 28 Jun 2012 02:18:10 +0200
In-Reply-To: <1340829332.23146.86.camel@ted> (Richard Purdie's message of
	"Wed, 27 Jun 2012 21:35:32 +0100")
Message-ID: <lyr4t0e1bx.fsf@ensc-virt.intern.sigma-chemnitz.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.97 (gnu/linux)
MIME-Version: 1.0
Sender: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
X-DSPAM-Result: Innocent
X-DSPAM-Probability: 0
X-DSPAM-Confidence: 0.84
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
X-List-Received-Date: Thu, 28 Jun 2012 00:29:03 -0000
Content-Type: text/plain

Richard Purdie <richard.purdie@linuxfoundation.org> writes:

>>              # Principle of least surprise. We could end up with https matching against http and 
>>              # generating "files://" urls if we use the regexp engine below.
>> -            if i != uri_decoded[loc]:
>> +            if not re.match(i, uri_decoded[loc]):
>>                  return None
>>              result_decoded[loc] = uri_replace_decoded[loc]
>>          elif (re.match(i, uri_decoded[loc])):
>
> I'm not picking on you (Enrico) here, there is a problem with my change
> and we probably should revert my change in this area.
>
> However the above patch fails "bitbake-selftest" and introduces a
> regression.

selftest fails here in

| ERROR: test_gitfetch_premirror3 (bb.tests.fetch.FetcherTest)
| CalledProcessError: Command 'git clone git://git.openembedded.org/bitbake /tmp/tmpt_dDVD/sourcemirror.git 2> /dev/null' returned non-zero exit status 128

and

| FAIL: test_urilist2 (bb.tests.fetch.FetcherTest)
| AssertionError: Lists differ: ['file:///somepath/downloads/b... != ['file:///someotherpath/downlo...
| - ['file:///somepath/downloads/bitbake-1.0.tar.gz',
| -  'file:///someotherpath/downloads/bitbake-1.0.tar.gz']
| ? ^
| 
| + ['file:///someotherpath/downloads/bitbake-1.0.tar.gz']
| ? ^

(I am some days behind current bitbake master, so these might be fixed
in the meantime)


Nothing which seems to be related to the patch.


> The trouble is its sees:
>
> https://.*/.* file:///someplace/
>
> but returns a url like files:// which the fetcher doesn't understand.
> Suggestions on how to fix this are welcome.

I do not see how my patch can cause such a rewrite. The troublesome
're.sub()' is done in a branch for loc != 0 only and won't be applied on
the protocol part.


Enrico



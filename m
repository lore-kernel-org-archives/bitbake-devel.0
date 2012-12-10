Received: from mail.cvg.de ([62.153.82.30])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <enrico.scholz@sigma-chemnitz.de>)
	id 1Ti1JS-0003qu-PN; Mon, 10 Dec 2012 12:14:18 +0100
Received: from ensc-virt.intern.sigma-chemnitz.de
	(ensc-virt.intern.sigma-chemnitz.de [192.168.3.24])
	by mail.cvg.de (8.14.4/8.14.4) with ESMTP id qBAAxiKf016244
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 10 Dec 2012 11:59:45 +0100
Received: from ensc by ensc-virt.intern.sigma-chemnitz.de with local (Exim
	4.76) (envelope-from <ensc@sigma-chemnitz.de>)
	id 1Ti15L-0006I0-UI; Mon, 10 Dec 2012 11:59:44 +0100
From: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
References: <lyfw3ii2ef.fsf@ensc-virt.intern.sigma-chemnitz.de>
	<1354882981.12928.24.camel@ted>
Date: Mon, 10 Dec 2012 11:59:43 +0100
In-Reply-To: <1354882981.12928.24.camel@ted> (Richard Purdie's message of
	"Fri, 07 Dec 2012 12:23:01 +0000")
Message-ID: <ly8v96mau8.fsf@ensc-virt.intern.sigma-chemnitz.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.1 (gnu/linux)
MIME-Version: 1.0
Sender: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
X-DSPAM-Result: Innocent
X-DSPAM-Probability: 0
X-DSPAM-Confidence: 1
X-Spam-Score: -5.3
X-Spam-Level: -----
X-Spam-Tests: AWL,BAYES_00,RP_MATCHES_RCVD,SPF_NEUTRAL,DSPAM_INNOCENT
X-Scanned-By: MIMEDefang 2.73
Cc: bitbake-devel@lists.openembedded.org,
	openembedded-core@lists.openembedded.org
Subject: Re: Complete rebuilds due to random hashes
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
X-List-Received-Date: Mon, 10 Dec 2012 11:14:19 -0000
Content-Type: text/plain

Richard Purdie <richard.purdie@linuxfoundation.org> writes:

>> I have encountered the problem the whole distribution gets rebuilt when
>> I change a single, completely unrelated variable (e.g. BB_DISKMON_DIRS).
>> 
>> Dumping data in _build_data() (siggen.py) revealed that sometimes a
>> gitpkgv_do_configure() (or _do_compile/install...) function is in the
>> deps, sometimes not.
> ...
> I would add some debug code into gitpkgv.bbclass around the functions
> there, perhaps a try:/except: and see if there is some kind of uncaught
> exception happening for one of your recipes. If that isn't it, I would
> be intersted to understand what you have which is breaking out the
> fetcher. It could be a SkipPackage exception under some circumstance for
> example.

Sorry, my fault.  I patched bitbake to ignore SkipPackage[1] and missed
that the global 'classes' variable was not reset.

fwiw, patch was required to allow 'gitpkgv' recipes to be skipped
e.g. because no git branch exists for the corresponding setup. Expansion
of PV will fail in this case with a fetcher error.




Enrico

Footnotes: 
[1]  https://github.com/ensc/bitbake/commit/fe0093b34dabe979c81a9b428de96ba73a4e3edb
     (working variant)



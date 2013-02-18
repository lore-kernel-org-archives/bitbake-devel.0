Received: from mail.cvg.de ([62.153.82.30])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <enrico.scholz@sigma-chemnitz.de>) id 1U7Ux1-0007My-RA
	for bitbake-devel@lists.openembedded.org;
	Mon, 18 Feb 2013 18:56:29 +0100
Received: from ensc-virt.intern.sigma-chemnitz.de
	(ensc-virt.intern.sigma-chemnitz.de [192.168.3.24])
	by mail.cvg.de (8.14.4/8.14.4) with ESMTP id r1IHbKYA023440
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 18 Feb 2013 18:37:22 +0100
Received: from ensc by ensc-virt.intern.sigma-chemnitz.de with local (Exim
	4.76) (envelope-from <ensc@sigma-chemnitz.de>) id 1U7UeW-0000MZ-Au
	for bitbake-devel@lists.openembedded.org;
	Mon, 18 Feb 2013 18:37:20 +0100
From: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 18 Feb 2013 18:37:20 +0100
Message-ID: <lyobfhcylr.fsf@ensc-virt.intern.sigma-chemnitz.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.1 (gnu/linux)
MIME-Version: 1.0
Sender: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
X-DSPAM-Result: Innocent
X-DSPAM-Probability: 0
X-DSPAM-Confidence: 1
X-Spam-Score: -5.6
X-Spam-Level: -----
X-Spam-Tests: AWL,BAYES_00,RP_MATCHES_RCVD,SPF_NEUTRAL,DSPAM_INNOCENT
X-Scanned-By: MIMEDefang 2.73
Subject: Broken quoting in bb.utils.remove()
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
X-List-Received-Date: Mon, 18 Feb 2013 17:56:29 -0000
Content-Type: text/plain

Hi,

commit 96088ebdec08e49ba9e8dbcac437bfcdc21f5983 causes unwanted effects
when path contains special shell chars like whitespaces, '$', ';' or
'\'.

Something like

- subprocess.call("rm -rf %s" % path, shell=True)
+ subprocess.call(['rm', '-rf'] + glob.glob(path), shell=False)

would restore previous behavior.


Enrico



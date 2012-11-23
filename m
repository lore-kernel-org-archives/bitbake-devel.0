Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1TbxFY-0004cU-AN; Fri, 23 Nov 2012 18:41:12 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id qANHR1UT005001;
	Fri, 23 Nov 2012 17:27:01 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 04292-04; Fri, 23 Nov 2012 17:26:57 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id qANHQqmR004953
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 23 Nov 2012 17:26:53 GMT
Message-ID: <1353691611.1361.28.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>, openembedded-core
	<openembedded-core@lists.openembedded.org>
Date: Fri, 23 Nov 2012 17:26:51 +0000
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: Constantin Musca <constantinx.musca@intel.com>
Subject: RFC: Versioning of git recipes (and incremental PR)
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
X-List-Received-Date: Fri, 23 Nov 2012 17:41:12 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Currently we have some rather complex and potentially broken code in the
fetcher code to deal with the the fact that you don't get incremental
versions from git revisions easily. The system currently has a database
and generates incremental numbers so PV becomes something like:

0.1+git1-deadbeefdecafbad

or for perverse recipes with more than one git source:

0.1+git1-deadbeefdecafbad-git3-decafbaddeadbeef

We currently have a bug that this doesn't interact well with sstate
feeds since you have to have a single persistdb for any given sstate
feed. It won't break in that sstate will just not be used but that is
inefficient.

The fact we need to have increasing values in the field is a very
similar problem to the incremental PR for package fields that we're
addressing with the PR server.

I've therefore taken a step back and considered things and am proposing
that we adapt the PR server to handle this issue and then drop the code
from the fetcher. The rough implementation of this would mean that:

* PV would become 0.1+gitAUTOINC-deadbeefdecafbad-decafbaddeadbeef

* We'd have one incrementing value rather than several.

* That the code would detect a PV containing AUTOINC and set PKGV to the
same thing with AUTOINC replaced with the "auto PR" value

* We'd do this in parallel with the usual auto PR value. In PR server
terms this means likely in the same data table using "git-PV" as the key
and just call the API with a different key name.

* If the PR server isn't running, this would just set PKGV to PV but
with AUTOINC set to 0. This would mean you wouldn't get updating package
feeds but usual image creation would be just fine.

* There are some complexities for data import and export we need to
consider and work through.

All things considered I think this would be a nice improvement and allow
us to have one good set of "incremental" code and simplify the fetchers.

I'm open to discussion... :)

Cheers,

Richard




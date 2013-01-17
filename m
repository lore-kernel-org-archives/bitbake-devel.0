Received: from mout.gmx.net ([212.227.17.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <hallerharry@gmx.de>) id 1TvvAG-0007ur-GU
	for bitbake-devel@lists.openembedded.org;
	Thu, 17 Jan 2013 20:30:16 +0100
Received: from mailout-de.gmx.net ([10.1.76.20]) by mrigmx.server.lan
	(mrigmx002) with ESMTP (Nemesis) id 0LxZlV-1Sqeku2Bad-017AqH for
	<bitbake-devel@lists.openembedded.org>; Thu, 17 Jan 2013 19:50:47 +0100
Received: (qmail 7014 invoked by uid 0); 17 Jan 2013 18:50:47 -0000
Received: from 37.209.58.107 by www018.gmx.net with HTTP;
	Thu, 17 Jan 2013 19:50:45 +0100 (CET)
Date: Thu, 17 Jan 2013 19:50:45 +0100
From: hallerHarry@gmx.de
Message-ID: <20130117185045.24970@gmx.net>
MIME-Version: 1.0
To: bitbake-devel@lists.openembedded.org
X-Authenticated: #1423391
X-Flags: 0001
X-Mailer: WWW-Mail 6100 (Global Message Exchange)
X-Priority: 3
X-Provags-ID: V01U2FsdGVkX1/juWgIaL/j5Y63ySvOVdwBiizHyoDM6tijyUdZ2z
	IC5HxEBzUfzPoHAGPMVjzHBO6eiHmtG7RgcA== 
X-GMX-UID: Ui2KcKVoeSEqX37bfnQhH5Z+IGRvb8D9
X-Mailman-Approved-At: Fri, 18 Jan 2013 13:04:19 +0100
Subject: bitbake DEPENDS problem
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
X-List-Received-Date: Thu, 17 Jan 2013 19:30:25 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hi,

I've got the below described minimalistic bitbake setup. There are two recipes where one recipe (mySecPkg.bb) DEPENDS on the other (myPkg.bb).
According to the OpenEmbedded User Manual [1] and the Yocto Pokey Manual Section 2.3 [2] I would have expected if I run build against mySecPkg that bitbake obeys inter-package dependencies and also builds myPkg since mySecPkg DEPENDS on it.
But this is not the case. Bitbake only builds mySecPkg. Is there something wrong with my assumption or setup? I would appreciate if someone could shed some light on that.

Thanks in advance for any assistance provided!

$ env -i PATH=$PATH:./bitbake-1.17.0/bin bitbake -DDD mySecPkg
...
DEBUG: providers for myPkg are: ['myPkg']
...
DEBUG: Resolved 0 extra dependencies
...
NOTE: Pruned 1 inactive tasks, 1 left

Here is the setup:

|-- bitbake
|   |-- bin
|   |   `-- bitbake
|   `-- ...
|
|-- conf
|   |-- bblayers.conf
|   |      BBPATH = "${TOPDIR}"
|   |      BBFILES ?= ""
|   |      BBLAYERS ?= "meta"
|   |
|   `-- local.conf
|          BB_NUMBER_THREADS = "2"
|          PARALLEL_MAKE = "-j 2"
|
`-- meta
    |-- conf
    |   |-- layer.conf
    |   |      BBPATH := "${LAYERDIR}:${BBPATH}"
    |   |      BBFILES := "${BBFILES} ${LAYERDIR}/recipes/*.bb"
    |   |
    |   `-- bitbake.conf
    |          ...
    |          require local.conf
    |
    |-- classes
    |   |-- base.bbclass
    |   |      bbnote() {
    |   |         echo "NOTE:" "$*"
    |   |      }
    |   |
    |   |      addtask build
    |   |      do_build[dirs] = "${TOPDIR}"
    |   |      #do_build[nostamp] = "1"
    |   |      python base_do_build () {
    |   |         bb.note("The included,...")
    |   |      }
    |   |
    |   |      EXPORT_FUNCTIONS do_build
    |   |
    |   `-- myBaseClass.bbclass
    |          addtask do_build
    |          do_build() {
    |             bbnote "*** myBaseClass::do_build()"
    |          }
    |
    `-- recipes
        |-- myPkg_0.1.bb
        |      PN = "myPkg"
        |      PV = "0.1"
        |
        |      inherit myBaseClass
        |
        |      do_build() {
        |         bbnote "*** myPkg::do_build()"
        |      }
        |
        `-- mySecPkg_0.1.bb
               PN = "mySecPkg"
               PV = "0.1"
               DEPENDS = "myPkg"

               inherit myBaseClass

               do_build() {
                  bbnote "*** mySecPkg::do_build()"
                  return 0
               }
 
[1] http://docs.openembedded.org/usermanual/usermanual.html
[2] http://www.yoctoproject.org/docs/1.3/poky-ref-manual/poky-ref-manual.html

Regards
 HH




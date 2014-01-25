Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 19F6F6CBB4
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 25 Jan 2014 13:28:39 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s0PDSPZm018737; Sat, 25 Jan 2014 13:28:26 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id GItfei278cJg; Sat, 25 Jan 2014 13:28:25 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s0PDSJoX018733
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 25 Jan 2014 13:28:21 GMT
Message-ID: <1390656494.17424.220.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Sat, 25 Jan 2014 13:28:14 +0000
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Cc: Bill Traynor <wmat@alphatroop.com>, "Rifenbark,
	Scott M" <scott.m.rifenbark@intel.com>
Subject: [PATCH 00/45] Bitbake manual updates pull request
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Sat, 25 Jan 2014 13:28:40 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

I've worked with Scott Rifenbark to incorporate Bill Traynor's BitbBake
manual work and then work on improving it. The following patch set
incorporates the various changes. Bill's branch was significantly
modified to separate out whitespace changes from content changes. In
future we'll try and get this merged in smaller chunks but this brings
us into sync which I think all will agree is a good thing. I'm not going
to spam the list with the individual patches, anyone interested can see
them in the branch.

The following changes since commit 2ca15117e4bbda38cda07511d0ff317273f91528:

  toaster: Toaster GUI, generic search, filter and order (2014-01-10 14:13:53 +0000)

are available in the git repository at:

  git://git.pokylinux.org/poky-contrib srifenbark/wmat3
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=srifenbark/wmat3

Bill Traynor (6):
  usermanual: Updated CC License to version 3.0
  usermanual: Renamed manual dir to user-manual to be consistent.
  user-manual: Import YP Docs templates for usermanual improvements
  gitignore: Update for recent docs changes
  documentation: Add README based off the YP docs one
  user-manual-intro.xml: Re-write of BitBake introduction.

Richard Purdie (29):
  user-manual: Separate out chapters into individual files
  user-manual-intro: Expand introduction and fix spelling mistakes
  user-manual-intro: Update/improve whitespace
  user-manual-intro: Add obtaining bitbake and summary sections
  user-manual-intro: Various minor cleanups/improvements
  user-manual-metadata: Add section ids for most sections
  user-manual-metadata: Reorder sections to more logical order
  user-manual-metadata: Update whitespace (no content changes)
  user-manual-metadata: Replace screen tags with literallayout tags
  user-manual-metadata: Use filename tags instead of literal and varname
    tags
  user-manual-metadata: Editing pass over the manual chapter
  user-manual-metadata: Add lists of common events
  user-manual-metadata: Add section about data store operations
  user-manual-metadata: Rework section about shell/python functions
  user-manual-metadata: Add section about running tasks and the
    environment
  user-manual-metadata: Add section about INHERIT
  user-manual-metadata: Add section about layers
  user-manual-metadata: Expand parsing process docuemtnation
  user-manual-metadata: Clean up task flag section
  user-manual-metadata: Clean up task documentation
  user-manual-fetching: Change the file whitespace
  user-manual-fetching: Change screen -> literallayout
  user-manual-fetching: Change varname/emphasis tags to filename
  user-manual-fetching: Editing pass over the manual chapter
  user-manual-bitbakecommand: Update help text output with that from
    bitbake master
  user-manual-bitbakecommand: Reform whitespace
  user-manual-bitbakecommand: Replace screen tags with literallayout
  user-manual-bitbakecommand: Standardise on section tags, not example
  user-manual-bitbakecommand: Various edits/cleanups

Scott Rifenbark (10):
  user-manual-intro.xml: Added "Concepts" section.
  user-manual.xml: Cleanup on the title page.
  user-manual-hello.xml: Added new chapter for "Hello World Example"
  user-manual-ref-variavbles.xml: Added new glossary chapter.
  user-manual-metadata.xml: Renamed section tag
  user-manual-customization.xsl: Updated param list to pass
  template/titlepage.templates.xml: Suppress Title Text.
  user-manual-ref-variables.xml: Editing pass.
  user-manual-ref-variables.xml: Fixed references to "Build Directory".
  user-manual-ref-variables.xml: Added 10 new variables to the glossary.

 .gitignore                                     |    3 +
 doc/Makefile                                   |   77 ++
 doc/README                                     |   39 +
 doc/manual/Makefile                            |   56 -
 doc/manual/usermanual.xml                      |  627 ----------
 doc/poky.ent                                   |   59 +
 doc/template/Vera.ttf                          |  Bin 0 -> 65932 bytes
 doc/template/Vera.xml                          |    1 +
 doc/template/VeraMoBd.ttf                      |  Bin 0 -> 49052 bytes
 doc/template/VeraMoBd.xml                      |    1 +
 doc/template/VeraMono.ttf                      |  Bin 0 -> 49224 bytes
 doc/template/VeraMono.xml                      |    1 +
 doc/template/db-pdf.xsl                        |   64 +
 doc/template/draft.png                         |  Bin 0 -> 24847 bytes
 doc/template/fop-config.xml                    |   58 +
 doc/template/titlepage.templates.xml           | 1259 ++++++++++++++++++++
 doc/tools/docbook-to-pdf                       |   51 +
 doc/user-manual/figures/bitbake-title.png      |  Bin 0 -> 5086 bytes
 doc/{manual => user-manual}/html.css           |    0
 doc/user-manual/user-manual-bitbakecommand.xml |  367 ++++++
 doc/user-manual/user-manual-customization.xsl  |   14 +
 doc/user-manual/user-manual-fetching.xml       |  230 ++++
 doc/user-manual/user-manual-hello.xml          |  321 ++++++
 doc/user-manual/user-manual-intro.xml          |  336 ++++++
 doc/user-manual/user-manual-metadata.xml       | 1175 +++++++++++++++++++
 doc/user-manual/user-manual-ref-variables.xml  | 1474 ++++++++++++++++++++++++
 doc/user-manual/user-manual-style.css          |  978 ++++++++++++++++
 doc/user-manual/user-manual.xml                |   86 ++
 28 files changed, 6594 insertions(+), 683 deletions(-)
 create mode 100644 doc/Makefile
 create mode 100644 doc/README
 delete mode 100644 doc/manual/Makefile
 delete mode 100644 doc/manual/usermanual.xml
 create mode 100644 doc/poky.ent
 create mode 100644 doc/template/Vera.ttf
 create mode 100644 doc/template/Vera.xml
 create mode 100644 doc/template/VeraMoBd.ttf
 create mode 100644 doc/template/VeraMoBd.xml
 create mode 100644 doc/template/VeraMono.ttf
 create mode 100644 doc/template/VeraMono.xml
 create mode 100644 doc/template/db-pdf.xsl
 create mode 100644 doc/template/draft.png
 create mode 100644 doc/template/fop-config.xml
 create mode 100644 doc/template/titlepage.templates.xml
 create mode 100755 doc/tools/docbook-to-pdf
 create mode 100644 doc/user-manual/figures/bitbake-title.png
 rename doc/{manual => user-manual}/html.css (100%)
 create mode 100644 doc/user-manual/user-manual-bitbakecommand.xml
 create mode 100644 doc/user-manual/user-manual-customization.xsl
 create mode 100644 doc/user-manual/user-manual-fetching.xml
 create mode 100644 doc/user-manual/user-manual-hello.xml
 create mode 100644 doc/user-manual/user-manual-intro.xml
 create mode 100644 doc/user-manual/user-manual-metadata.xml
 create mode 100644 doc/user-manual/user-manual-ref-variables.xml
 create mode 100644 doc/user-manual/user-manual-style.css
 create mode 100644 doc/user-manual/user-manual.xml




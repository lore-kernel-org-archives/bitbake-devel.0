Received: from cpanel7.indieserve.net (cpanel7.indieserve.net [199.212.143.8])
 by mx.groups.io with SMTP id smtpd.web12.8815.1588688759905447029
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 05 May 2020 07:26:00 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: crashcourse.ca, ip: 199.212.143.8, mailfrom: rpjday@crashcourse.ca)
Received: from cpeac202e043973-cmac202e043970.sdns.net.rogers.com ([174.114.100.179]:57078 helo=localhost.localdomain)
	by cpanel7.indieserve.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <rpjday@crashcourse.ca>)
	id 1jVyWE-00Gme0-KF
	for bitbake-devel@lists.openembedded.org; Tue, 05 May 2020 10:25:59 -0400
Date: Tue, 5 May 2020 10:25:56 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To: BitBake developer list <bitbake-devel@lists.openembedded.org>
Subject: any point in defining classname_functionname() if not exporting it?
Message-ID: <alpine.LFD.2.21.2005051010500.15969@localhost.localdomain>
MIME-Version: 1.0
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel7.indieserve.net
X-AntiAbuse: Original Domain - lists.openembedded.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel7.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel7.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Content-Type: text/plain; charset=US-ASCII


  still in BB manual, section 3.5.6, "Flexible Inheritance for Class
Functions", that section makes perfect sense but it's not clear if
there is any value to defining a function of the form
classname_functionmame() if you're not going to export it with
EXPORT_FUNCTIONS.

  case in point -- cmake.bbclass. at bottom of file, we see some
perfectly reasonable exporting:

EXPORT_FUNCTIONS do_configure do_compile do_install do_generate_toolchain_file

but if you grep, there is an additional function being defined of that
form:

cmake_do_generate_toolchain_file() {
cmake_do_configure() {
cmake_runcmake_build() {             <-- this one
cmake_do_compile()  {
cmake_do_install() {

sure, that function is invoked internally in that class file, but
without being exported, is there any reason that function has a
"cmake_" prefix?

rday

p.s. the same thing occurs in go.bbclass, if that's of any interest.

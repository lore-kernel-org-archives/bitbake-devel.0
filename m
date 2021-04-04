Received: from cpanel8.indieserve.net (cpanel8.indieserve.net [199.212.143.3])
 by mx.groups.io with SMTP id smtpd.web08.46320.1617565875369366804
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 04 Apr 2021 12:51:15 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: crashcourse.ca, ip: 199.212.143.3, mailfrom: rpjday@crashcourse.ca)
Received: from cpef81d0f814063-cmf81d0f814060.cpe.net.cable.rogers.com ([174.114.57.56]:47466 helo=fedora)
	by cpanel8.indieserve.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94)
	(envelope-from <rpjday@crashcourse.ca>)
	id 1lT8m9-004rWe-IQ
	for bitbake-devel@lists.openembedded.org; Sun, 04 Apr 2021 15:51:14 -0400
Date: Sun, 4 Apr 2021 15:51:10 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
To: BitBake developer list <bitbake-devel@lists.openembedded.org>
Subject: still confused about valid wildcarding for bbappend files
Message-ID: <e66c2878-5f82-394b-e6a-ccd45dc44c73@crashcourse.ca>
MIME-Version: 1.0
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel8.indieserve.net
X-AntiAbuse: Original Domain - lists.openembedded.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel8.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel8.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Content-Type: multipart/mixed; boundary="8323328-1220412624-1617565873=:8705"

--8323328-1220412624-1617565873=:8705
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT


from current bitbake manual:

https://docs.yoctoproject.org/bitbake/bitbake-user-manual/bitbake-user-manual-intro.html?highlight=wildcard#append-files

"The use of the ” % ” character is limited in that it only works
directly in front of the .bbappend portion of the append file’s name.
You cannot use the wildcard character in any other location of the
name."

  that *appears* to suggest that you can have one (and exactly one)
"%" before the ".bbappend" suffix. so how does that explanation cover
examples in some of the OE layers like:

  meta-security/recipes-kernel/linux/linux-%_5.%.bbappend
  meta-anaconda/recipes-gnome/gtk+/gtk+3_%.%.%.bbappend

rday

--8323328-1220412624-1617565873=:8705--

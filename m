Return-Path: <jan.kiszka@web.de>
Received: from mout.web.de (mout.web.de [212.227.15.3])
	by mail.openembedded.org (Postfix) with ESMTP id 514AA605BE
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 18 Nov 2018 10:07:07 +0000 (UTC)
Received: from [192.168.1.10] ([95.157.57.47]) by smtp.web.de (mrweb002
	[213.165.67.108]) with ESMTPSA (Nemesis) id 0M8hdL-1fTabA2vrf-00wGtN
	for
	<bitbake-devel@lists.openembedded.org>; Sun, 18 Nov 2018 11:07:07 +0100
Resent-From: Jan Kiszka <jan.kiszka@web.de>
Resent-To: bitbake-devel@lists.openembedded.org
Resent-Date: Sun, 18 Nov 2018 11:07:07 +0100
Resent-Message-ID: <60726ad9-16f6-c489-1db6-ed7468d649fb@web.de>
Resent-User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); de;
	rv:1.8.1.12) Gecko/20080226 SUSE/2.0.0.12-1.1
	Thunderbird/2.0.0.12 Mnenhy/0.7.5.666
To: bitbake-devel@lists.openembedded.org
From: Jan Kiszka <jan.kiszka@web.de>
Message-ID: <dcf35fbf-e76a-4e93-c0c7-19cc26ecfe2c@web.de>
Date: Sun, 18 Nov 2018 10:59:34 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); de; rv:1.8.1.12)
	Gecko/20080226 SUSE/2.0.0.12-1.1 Thunderbird/2.0.0.12 Mnenhy/0.7.5.666
MIME-Version: 1.0
X-Provags-ID: V03:K1:Rd5qLPceRaO6hynipjLXvyAk9GWxtPwZijndoWfCmFQZd3R8b0C
	DREYF5a0S9pmM6ysZHpgTFL2mwX7baCwdiwtsnNARSuigUUbuGBVQixe90W/Zg6wgk3sRnx
	Hm58VqV4ftlMy8XX/VPh1vco/lK0aJ/Hv8Wb5Mj6w6D3aF4lroBrhUjLpQWLVb+FREODmHu
	Q81joqCICKnTuQcDxL8ug==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V01:K0:Ladf0PM0l8M=:K44kifHcLkzPfGxbGpl9Qm
	HvrVUtNg3OMlBsrK1A9aCS3XOL1GkQ0T2IR0BQsOHbJjp696qn94U9hcTgYwMm9O7aIikawDJ
	Bf3nbEcYkKho+Bj1pNLFdWlbs8+zqIGj9rRmOxS0bXzqi3pfnOi8mKt4NmoEMe7nRXmibpC5k
	gc6u0A5RMrtthNCHNOBHzsNELiaJI0BoIeUHbUK+Glrx6qKufxBa3gbKlXuGwdddp+6Nc3ItG
	GlwV1FaI3NevuU45o0mNJgBHTVZfAvLutaNCKpZeOK+jXLjISuez9pFEXNJ1UQKkLeWuKTmvd
	9zK7KxnbMQujp4g6Bnf6298l/0Nxd6dlVrlRoI0+bjQrs+e3NhPtTdwtNedvofiuoMD72+H7y
	S7mgz8qSin09Ctq230XXCmqdmIKKLa7LGaJnGUa83bBhilMLq+DIq1SmfT3roBjW9a0i4w+6C
	2qpFnBVPCojNwBIvW6mYLgQXdEGJSMsiCRdiPmHvg+l18d5oxKxq3DPPK/+Wu8IW7ln03tqth
	Ul0T0+RXoDt3KAQqfujlQUos913ItpfEzYgqbiemi+GpMfFG65eo0/b/F3iLNBDrSanB5rfmw
	kU1I62iYPDooDF5JEpHodfijszFC2ZXlEGwdQa9qfxpVHy0lSsZR0h4FtaJ9fYGh40kJfsrIz
	Vxw/olwhjsXAiiOw0PhMLMFcfyP2w4kPjvAO91JWPGrJkrGrpB2Ik5M9kbdN2gvznQphYCRLa
	hIhZKtnn4OsmhxXBJhaAxDps09UInCQ6kvDkmIZg+Bcg0ZCbJmG/IA5G7rPcmeGJRiKDFELMu
	7EuFzd2m9keSivAwil3rSnm2JuMQzexj6/xSxKG9nEi903Sr8CEHSGer9Yd2huvE/ZhAjcfNI
	HkBTsq8lwODms5mRmNrsHgUtsowFLk9uy7jHEwDVoGWPJv64HyNRk6W0Zsmxbe
Subject: Regression caused by new multiconfig dependency
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
X-List-Received-Date: Sun, 18 Nov 2018 10:07:07 -0000
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

Hi all,

since da8cb8633504 ("bitbake: Add support for multiconfig dependencies"), it's 
no longer possible to write recipes that have multiconfig-dependent names:


mc1.conf:
MACHINE = "a"

mc2.conf:
MACHINE = "b"

some-target.bb:
PN = "some-target-${MACHINE}"

local.conf:
BBMULTICONFIG = "mc1 mc2"


# bitbake multiconfig:mc1:some-target-a
[...]
ERROR: Nothing PROVIDES 'some-target-a'. Close matches:
   some-target-b

# bitbake multiconfig:mc2:some-target-b
ERROR: Nothing PROVIDES 'some-target-b'. Close matches:
   some-target-a


That works fine when going back to da8cb8633504^ or when only having the 
selected multiconfig in BBMULTICONFIG. Seems the parser stumbles while 
processing the unselected multiconfig paths.

Jan


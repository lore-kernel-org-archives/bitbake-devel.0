Return-Path: <prvs=110bfcb55=Mikko.Rapeli@bmw.de>
X-Greylist: delayed 429 seconds by postgrey-1.34 at layers.openembedded.org;
	Fri, 02 Aug 2019 07:45:05 UTC
Received: from esa6.bmw.c3s2.iphmx.com (esa6.bmw.c3s2.iphmx.com
	[68.232.139.124])
	by mail.openembedded.org (Postfix) with ESMTP id 707EA7F2FB
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  2 Aug 2019 07:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=bmw.de; i=@bmw.de; q=dns/txt; s=mailing1;
	t=1564731908; x=1596267908;
	h=from:to:cc:subject:date:message-id:references:
	in-reply-to:content-id:content-transfer-encoding: mime-version;
	bh=x45KArdW+WnN6QjnPCy5SnkUzOozYClFI23GksIVLao=;
	b=DtfM+PyTrr71l4UXfJP9gndCCBmFY8fjQlj2ggKq4uRJjogjK69OOunF
	WpD8tNijn9Nmzo2V9IqS273TXI9/2rcU+4rmQJCZH6OPbUlrO4ZhVr++P
	CA63RwmhjQtjxF46VO9CAclbyEHRunbTRgVsGyH/hGE8uV9YwGlMSrtX/ 4=;
IronPort-SDR: 58c7O0dRA6yeQdHq1Cj2E+6qNKlFb1cLH2LE6RgXxYgUYqZgLM3Jw3nd8alNdXfU2ishLuwekt
	+EV5r09QaV5X+6zYU2pShpP/Yy9nEXiUqTUMXJrr5KuUQmw9knHFHg1KCy9SWC48mROAjyIhIv
	jYlrjUgy94feL09qdh2YUg//GPqUrBeiNL0BWEwEKPkHh/bUNrt95IlU/ybcy7oNa1vaoVf5/c
	VDAy3ZoIi6ug5dvm1bk1slGhJtMXL/nlP331SEVbVEUdnLRB8gyIRElyWvtfp+M+3Wenvsxw0Z
	Ik8=
Received: from esagw4.bmwgroup.com (HELO esagw4.muc) ([160.46.252.39]) by
	esa6.bmw.c3s2.iphmx.com with ESMTP/TLS; 02 Aug 2019 09:37:57 +0200
Received: from esabb4.muc ([160.50.100.33])  by esagw4.muc with ESMTP/TLS;
	02 Aug 2019 09:37:43 +0200
Received: from smucm10l.bmwgroup.net (HELO smucm10l.europe.bmw.corp)
	([160.48.96.48])
	by esabb4.muc with ESMTP/TLS; 02 Aug 2019 09:37:43 +0200
Received: from smucm10k.europe.bmw.corp (160.48.96.47) by
	smucm10l.europe.bmw.corp
	(160.48.96.48) with Microsoft SMTP Server (TLS;
	Fri, 2 Aug 2019 09:37:43 +0200
Received: from smucm10k.europe.bmw.corp ([160.48.96.47]) by
	smucm10k.europe.bmw.corp ([160.48.96.47]) with mapi id 15.00.1473.005;
	Fri, 2 Aug 2019 09:37:43 +0200
From: <Mikko.Rapeli@bmw.de>
To: <chris.laplante@agilent.com>
Thread-Topic: [OE-core] RFC: exposing information about the SRC_URI(s)/branch
	via buildhistory (or similar mechanism)
Thread-Index: AdVIiV4bZ0XUaI6MTqawP3i+Dxw25gAawieA
Date: Fri, 2 Aug 2019 07:37:43 +0000
Message-ID: <20190802073741.GI3459@hiutale>
References: <CY4PR12MB1653C06268B3B4B862119BE18BDE0@CY4PR12MB1653.namprd12.prod.outlook.com>
In-Reply-To: <CY4PR12MB1653C06268B3B4B862119BE18BDE0@CY4PR12MB1653.namprd12.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [192.168.221.38]
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org,
	Openembedded-core@lists.openembedded.org
Subject: Re: [OE-core] RFC: exposing information about the SRC_URI(s)/branch via buildhistory (or similar mechanism)
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
X-List-Received-Date: Fri, 02 Aug 2019 07:45:05 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <554F7A9EB981D84B801809F9E48A023F@bmwmail.corp>
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Aug 01, 2019 at 04:51:38PM +0000, chris.laplante--- via Openembedde=
d-core wrote:
<snip>
> I'm interesting in adding SRC_URI support to buildhistory (or a similar m=
echanism), and would like to get some input.

Yes to this.

Also would be nice if there was an easy way to add bitbake variables to
buildhistory.

I've patched our tree so that SRC_URI, LICENSE and CVE_PRODUCT are archived
in buildhistory. SRC_URI has many uses and changes and patches can
be easily identified. Same with LICENSE, any changes trigger a review.
CVE_PRODUCT is exported so that we can do QA check to make sure mapping
from CVE_PRODUCT for non CLOSED licenses exists to NVD database product
names (maintaining a white list of recipes which don't have any CVEs yet).

We've also changed the SDK name to be stable across builds and added
DISTRO to the path. In our case IMAGE_NAME and SDK_NAME will include
git tree tag and hash if tree is dirty, which changes buildhistory SDK path=
s
for every build with different input.

I could submit the patches if there is interest in them.

Cheers,

-Mikko=


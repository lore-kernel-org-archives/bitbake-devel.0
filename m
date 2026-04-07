Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE0F0F3D5E1
	for <webhook@archiver.kernel.org>; Tue,  7 Apr 2026 15:03:02 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.83586.1775574172192426257
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 07 Apr 2026 08:02:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=ODM9boN5;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=8557d86685=rob.woolley@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6376LvYl2986663
	for <bitbake-devel@lists.openembedded.org>; Tue, 7 Apr 2026 15:02:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PPS06212021; bh=5AdLGmFLg7o00vreCQi3
	djG67QwuYw5mcBTM2Sx/zLg=; b=ODM9boN5K3x90dxDxQkNo/xPEXncEWSHqdpb
	sOP7yZ0tqHWjE3NC32KhkJP/8crc0UXPx/mcLf8Z7m+xjsmzk0a/l8fdU9+wwD3H
	tX6bhOeHUAZ2bXtuCWDjd2j73HnvRYuCIIfo6A7+2dQZ2bDPll3Y73QI/J0E02hm
	x/834wv2kum8CdaQUFWv3q6CdjEyQUgDhVAzYJP/UkDS9KYLPQfyDMr5Ce4L/IhA
	oshPLoVSNiZm93j0SaovxRLlvf3qQYZQHa+MmV4GTFRWwl2e7bBXvBTBNCf7nWct
	y92WnD5E8Nd6Q1jCu/qPRvSl1Pbe9KpJfmpcApJNxJNZvpzppg==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4dcmrqgx3g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Tue, 07 Apr 2026 15:02:50 +0000 (GMT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Tue, 7 Apr 2026 08:02:50 -0700
Received: from ala-lpggp3.wrs.com (10.11.232.110) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Tue, 7 Apr 2026 08:02:49 -0700
From: Rob Woolley <rob.woolley@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH v2 0/9] bitbake-setup JSON Schema: Fix linting errors
Date: Tue, 7 Apr 2026 08:02:41 -0700
Message-ID: <20260407150250.104135-1-rob.woolley@windriver.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=RPCD2Yi+ c=1 sm=1 tr=0 ts=69d51c9b cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=klDOsUkWDRETUCZYPvoE:22 a=NEAV23lmAAAA:8 a=Q4-j1AaZAAAA:8
 a=FvXtA75T2-xMqMq02oUA:9 a=9H3Qd4_ONW2Ztcrla5EB:22
X-Proofpoint-ORIG-GUID: QHblVXrRK8z6e1oAtj4uBQ9k5_U04huI
X-Proofpoint-GUID: QHblVXrRK8z6e1oAtj4uBQ9k5_U04huI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDEzNyBTYWx0ZWRfXxqL8AT3A1fIt
 M8XPerpjhyjeWvVQQQ7m3mm1UG5CL20tlp94Ag9M5YsombgG1JQNMBgXVyAD+caj28J3CT4p8oA
 Mdv5QukfHw3vXy8q7buAW6M+5RHr+UGBTSZZlnYya8HiMOAgGwS7VvrcB19VzLAg3gTHZ9oQTCN
 NglpfJjrsOvi8M93ybEoPGeh1y8GOQ7dIAkCdafOgBFqqoCcz2aUk7RE2lSsbCWC9Rgb5PvqT6a
 7wewP3xtPg8hsgK2vZUU6C3x0qIP9Dq4Bb5C/fgm2rXAgLrvgmN6l1GrzwQQz3u6IbuWy8Tgr8V
 eh2ybKW8eR7xFjVEYeeAka/IHPmc9JKnHCn+VjHadW/J5WTpShD8dK3npcwgFsDqQyatlhAA9GV
 5aoawQZrC1ZlZAq9+XfeA6LqbH16YkOeFQnwpn8PkzM7VET1hwGhdGgxYF5piSVFJsVW6XMMm+i
 5ZYN45jRVfLHJOldE9g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_03,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 adultscore=0 spamscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070137
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 07 Apr 2026 15:03:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19343

UPDATES v2:
  The following updates were made to v2 of this series:
   * Include an additional patch fixing an existing typo
   * Update the examples property to wrap it in an array and
     add a required configuration element

This series fixes some linting errors in the JSON Schema.  Problems
were found using the https://github.com/sourcemeta/jsonschema tool.

Here are the steps used to install and use the tool to lint the schemas:

# Setup the jsonschema CLI tool
```
  python3 -m venv venv
  source venv/bin/activate
  pip install sourcemeta-jsonschema
```

# Validate the schemas

```
jsonschema lint setup-schema/bitbake-setup.schema.json
jsonschema lint setup-schema/layers.schema.json
```

# Check the examples

NOTE: The examples are annotations and are meant for humans reading the schema.
They do not typically get checked automatically by the JSON Schema validation
tools.  Use jq to extract the JSON object into its own file to check it
separately.

```
cd setup-schema

jq .examples[] bitbake-setup.schema.json  > bitbake-setup.schema-examples.json
jsonschema validate bitbake-setup.schema.json bitbake-setup.schema-examples.json


jq .examples[] layers.schema.json  > layers.schema-examples.json
jsonschema validate layers.schema.json layers.schema-examples.json
cd ..
```

# Check the default-registry/configurations
```
jsonschema validate setup-schema/bitbake-setup.schema.json default-registry/configurations/oe-nodistro-master.conf.json
jsonschema validate setup-schema/bitbake-setup.schema.json default-registry/configurations/oe-nodistro-whinlatter.conf.json
jsonschema validate setup-schema/bitbake-setup.schema.json default-registry/configurations/poky-master.conf.json
jsonschema validate setup-schema/bitbake-setup.schema.json default-registry/configurations/poky-whinlatter.conf.json
```


There are 2 outstanding types of linting errors related to the use of hyphen
in the property names and the enum currently having only one value:

  Set `properties` to identifier names that can be easily mapped to programming
  languages (matching [A-Za-z_][A-Za-z0-9_]*) (simple_properties_identifiers).

  An `enum` of a single value can be expressed as `const` (enum_to_const)

The former would require a larger discussion and potentially increasing the
version number. Updating the enum to include a new version would also resolve
the latter error.

I do not believe that the changes in this series merit increasing the version
of the schema.

Resolving these outstanding errors is not necessary for validating the
Bitbake Configuration files.

UPDATE v2: Additional testing was performed with oe-selftest.  This uses
    python3-jsonschema which is a different implementation and caught
    additional linting errors.


```
    git clone https://git.openembedded.org/bitbake
    
    ./bitbake/bin/bitbake-setup init --non-interactive poky-master poky machine/qemux86-64 distro/poky
    
    . /ala-lpggp31/rwoolley/oe-selftest-testing/bitbake-builds/poky-master/build/init-build-env
    
    echo 'SANITY_TESTED_DISTROS = ""' >> conf/local.conf
    
    oe-selftest -r bblayers.BitbakeLayers.test_bitbakelayers_setup \
                   bblayers.BitbakeLayers.test_bitbakelayers_updatelayer \
                   bblayers.BitbakeLayers.test_validate_examplelayersjson \
                   bblayers.BitbakeLayers.test_validate_bitbake_setup_default_registry
```


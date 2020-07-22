import React, {useState, useEffect} from 'react';

import axios from 'axios';
import moment from 'moment';
import 'moment/locale/id'; 

const useApi = () => {
    let [data, setData] = useState([]);
    moment.locale('id');

    useEffect(() => {
        fetchData();
    }, []);

    const fetchData = async props =>{
        await axios('https://youlead.id/wp-json/barav/v1/search')
        .then(item => {
            setData(item.data);
        });
    }

    const fetchImage = item => {
        let image = item.featured_image.large;

        if(image != ''){
            return image;
        }else{
            return `${process.env.PUBLIC_URL}/notfound.jpg`;
        }
    }

    const fetchTitle = item => {
        let title = item.title.substr(0, 50);

        return title + '...';
    }

    const fetchContent = item => {
        let content = item.content.substr(0, 100);
        const regex = /(<([^>]+)>)/ig;
        const result = content.replace(regex, '').replace(/\&nbsp;/g, '');

        return result + '...';
    }

    const fetchTime = item => {
        let time = moment(item.date_gmt).format('DD MMMM YYYY hh:mm:ss');
        return time;
    }

    return {
        data: data,
        fetchData: fetchData,
        fetchTime: fetchTime,
        fetchTitle: fetchTitle,
        fetchImage: fetchImage,
        fetchContent: fetchContent,
    }
}

export default useApi;
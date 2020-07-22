import React, {useState, useEffect} from 'react';
import axios from 'axios';

const useApi = () => {
    let [data, setData] = useState([]);

    useEffect(() => {
        fetchData();
    }, []);

    const fetchData = async props =>{
        await axios('https://youlead.id/wp-json/barav/v1/search')
        .then(item => {
            setData(item.data);
        });
    }

    return {
        data: data,
    }
}

export default useApi;